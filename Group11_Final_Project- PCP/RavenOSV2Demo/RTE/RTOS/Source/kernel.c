/*! \file kernel.c
    \brief Implements kernel level operations.
	  \details Maps operations to CMSIS interface. Performs scheduling and context switching.
*/
#include "threadIdle.h"
#include "CU_TM4C123.h"
#include "stdio.h"
#include "osObjects.h"                      // RTOS object definitions
#include "kernel.h"
#include "peripherals.h"
//TWPV6:  removed    #include "scheduler.h"
#include "trace.h"
#include "RTE_Components.h"

#define os_sysTickTicks 16000  ///< Number of ticks between two system timer interrupts. This would generate 1000 interruts/s on a 16MHz clock.
#define ENABLE_KERNEL_PRINTF 0 ///< Enables printf traces from kernel. Printf from the kernel may not be protected so use at own risk.

void __svc(0x00) os_start(void);              // OS start scheduler
void __svc(0x01) thread_yield(void);          // Thread needs to schedule a switch of context
void __svc(0x02) stack_alloc(os_tcb_p thread_p); // Initialize the process stack pointer PSP_array[thread_idx]
void SVC_Handler_C(unsigned int * svc_args);
void HardFault_Handler_C(unsigned int * svc_args);
void ScheduleContextSwitch(void);
void os_KernelEnterCriticalSection (void);
void os_KernelExitCriticalSection (void);

/// \var SysTick_count Event to tasks
volatile uint32_t systick_count=0;

/// Persistent Data used by OS
os_tcb_p curr_task=NULL;               ///< Current task
uint32_t svc_exc_return;            ///< EXC_RETURN use by SVC
uint32_t kernel_running = 0;        ///< flag whether the kernel is running or not
uint32_t kernel_busy = 0;           ///< flag whether the kernel is busy or not

//  ==== Kernel Control Functions ====

/// \brief Initialize the RTOS Kernel for creating objects.
/// \details Enable double-word stack alignment and initialize the Idle thread.
/// \return Status code that indicates the execution status of the function.
/// \note MUST REMAIN UNCHANGED: \b osKernelInitialize shall be consistent in every CMSIS-RTOS.
osStatus osKernelInitialize (void)
{
	os_KernelEnterCriticalSection();
	
	// Enable double-word stack alignment
	SCB->CCR |= SCB_CCR_STKALIGN_Msk; // Set STKALIGN bit (bit 9) of CCR
	
	// Enable lazy stacking for interrupt handlers.  This allows floating-point
	// instructions to be used within interrupt handlers, but at the expense of
	// extra stack usage.
	//
	ROM_FPULazyStackingEnable();	
	
	os_KernelExitCriticalSection();	
	
	// Initialize the Idle thread
	// Needs SVC exceptions not masked
	if (Init_threadIdle() != 0)
	{
		stop_cpu;
	}
	
	return osOK;
}

/// \brief Start the RTOS Kernel.
/// \return status code that indicates the execution status of the function.
/// \note MUST REMAIN UNCHANGED: \b osKernelStart shall be consistent in every CMSIS-RTOS.
osStatus osKernelStart (void)
{
	kernel_running = 1;
	os_start();
	return osOK;
}

/// \brief Check if the RTOS kernel is already started.
/// \note MUST REMAIN UNCHANGED: \b osKernelRunning shall be consistent in every CMSIS-RTOS.
/// \return 0 RTOS is not started, 1 RTOS is started.
int32_t osKernelRunning(void)
{
	return kernel_running;
}

#if (defined (osFeature_SysTick)  &&  (osFeature_SysTick != 0))     // System Timer available

/// \brief Get the RTOS kernel system timer counter 
/// \note MUST REMAIN UNCHANGED: \b osKernelSysTick shall be consistent in every CMSIS-RTOS.
/// \return RTOS kernel system timer as 32-bit value 
uint32_t osKernelSysTick (void)
{
  return systick_count;
}

#endif    // System Timer available

/// \brief Mark the entrance to a critical section (for interrupt-handling)
/// \details Kernel is marked as busy and interrupts (apart from NMI and fault handler) disabled.
///          This could be defined as a macro to avoid function overhead
void os_KernelEnterCriticalSection (void)
{
	// marking kernel as busy
	kernel_busy = 1;
	// Disabling interrupts so that the kernel can do any initialization work
	__disable_irq();
  return ;
}

/// \brief Mark the exit from a critical section (for interrupt-handling)
/// \details Kernel is marked as normal and interrupts enabled.
///          This could be defined as a macro to avoid function overhead
void os_KernelExitCriticalSection (void)
{
	// marking kernel as normal
	kernel_busy = 0;
	// Any pending interrupts can go now.
	__enable_irq();
  return ;
}

/// \brief Perform an SVC call to invoke scheduler.
void os_KernelInvokeScheduler (void)
{
	thread_yield();   // SVC( 1 )
  return ;
}

/// \brief Perform an SVC call to allocate stack for a thread
/// \param thread_idx The thread index in the PSP table to initialize
void os_KernelStackAlloc (os_tcb_p thread_p)
{
	stack_alloc(thread_p);
  return ;
}

// -------------------------------------------------------------------------
/*! 
    \brief SVC exception handler
    \details Extracts the stack frame location, saves the current EXC_RETURN, 
    runs the C part of the handler, and restores the new EXC_RETURN.
*/
__asm void SVC_Handler(void)
{
	CPSID  I        // Set PRIMASK  (Disable Interrupts)
  TST    LR, #4   // Extract stack frame location
  ITE    EQ
  MRSEQ  R0, MSP
  MRSNE  R0, PSP
  LDR    R1,=__cpp(&svc_exc_return) // Save current EXC_RETURN
  STR    LR,[R1]	
  BL     __cpp(SVC_Handler_C)       // Run C part of SVC_Handler
  LDR    R1,=__cpp(&svc_exc_return) // Load new EXC_RETURN
  LDR    LR,[R1]
	CPSIE  I        // Clear PRIMASK  (Enable Interrupts)
  BX     LR
  ALIGN  4
}

/*! 
    \brief C part of the SVC exception handler

     SVC 0 is initializing the OS and starting the scheduler.
     Each thread stack frame is initialized.
     
    \param svc_args Used to extract the SVC number 
*/
void SVC_Handler_C(unsigned int * svc_args)
{
  uint8_t svc_number;
  svc_number = ((char *) svc_args[6])[-2]; // Memory[(Stacked PC)-2]
	// marking kernel as busy
	kernel_busy = 1;
  switch(svc_number) {
		
		//************* SVC( 0 )   OS Start	
    case (0): // OS start		  
 	    // Starting the task scheduler
		  //TWP  playing a trick here!? by making curr = next, will make next's stack and current's stack the same stack!
		  //   will save (garbage) current register values, and then immediately restore them as next's initial values :-)
		curr_task = rtr_q_h; // Switch to head ready-to-run task (Current task)		
		//     when current task was put in RTRQ its state was set to RUNNING 
		  
		svc_exc_return = HW32_REG(( curr_task->stack_p )); // Return to thread with PSP
		__set_PSP(( (uint32_t) curr_task->stack_p + 10*4));  // Set PSP to @R0 of task 0 exception stack frame

		NVIC_SetPriority(PendSV_IRQn, 0xFF);       // Set PendSV to lowest possible priority
		if (SysTick_Config(os_sysTickTicks) != 0)  // 1000 Hz SysTick interrupt on 16MHz core clock
			{
				stop_cpu2;
				// Impossible SysTick_Config number of ticks
			}
		__set_CONTROL(0x3);                  // Switch to use Process Stack, unprivileged state
		__ISB();       // Execute ISB after changing CONTROL (architectural recommendation)			
		break;
		
		//************* SVC( 1 )	Thread Yield
    case (1): // Thread Yield
		if (curr_task != rtr_q_h)
			{ 
				// Context switching needed
				ScheduleContextSwitch();
			}		
		__ISB();       					
		break;
    
		//************* SVC( 2 )    Stack Frame Allocation for First Launch
		//TWPV6: no longer used!  Functionality moved to osThreadCreate ... case left here (for now) 
    case (2): // Stack Allocation
		__ISB();       			
		break;			
    default:
#if ((ENABLE_KERNEL_PRINTF) && (ENABLE_KERNEL_PRINTF == 1))
		printf("ERROR: Unknown SVC service number\n\r");
		printf("- SVC number 0x%x\n\r", svc_number);
#endif
		stop_cpu2;
		break;
  } // end switch
	
	// marking kernel as normal
	kernel_busy = 0;
}	

// -------------------------------------------------------------------------
/*! 
    \brief Handles context switch.

     Saves the current process context (stack, registers, pointer to stack).
     Loads the next process context.
*/
__asm void PendSV_Handler(void)
{ 
	CPSID    I        // Set PRIMASK  (Disable Interrupts)
  // Save current context
  MRS      R0, PSP     // Get current process stack pointer value
  TST      LR, #0x10   // Test bit 4. If zero, need to stack floating point regs
  IT       EQ
  VSTMDBEQ R0!, {S16-S31} // Save floating point registers
  MOV      R2, LR
  MRS      R3, CONTROL
  STMDB    R0!,{R2-R11}// Save LR,CONTROL and R4 to R11 on task stack (10 regs)
  LDR      R1,=__cpp(&curr_task)
  LDR      R2,[R1]     // Get pointer to current task tcb
	STR      R0,[R2]   // Save stack pointer in tcb 
  // -------------------------
  // Load next context
  LDR      R4,=__cpp(&rtr_q_h)
  LDR      R4,[R4]     // Get pointer to next task tcb
  STR      R4,[R1]     // Set curr_task = rtr_q_h
  LDR      R0,[R4] // Load stack_p from tcb 
  LDMIA    R0!,{R2-R11}// Load LR, CONTROL and R4 to R11 from task stack (10 regs)
  MOV      LR, R2
  MSR      CONTROL, R3
  TST      LR, #0x10   // Test bit 4. If zero, need to unstack floating point regs
  IT       EQ
  VLDMIAEQ R0!, {S16-S31} // Save floating point registers
  MSR      PSP, R0     // Set PSP to next task
	CPSIE    I        // Clear PRIMASK  (Enable Interrupts)
  BX       LR          // Return
  ALIGN  4
}
// -------------------------------------------------------------------------
/*! 
    \brief Manage timed services

     Increment SysTick counter, invoke scheduler and flag any context switching needed for PendSV to take care of.
*/
volatile uint32_t ticker=0;
void SysTick_Handler(void) // 1KHz
{
	os_KernelEnterCriticalSection();  // TWP ... why???
	// Increment systick counter 
  systick_count++;
	
	//TWPV6: SysTick heartbeat on BLUE LED
	switch (++ticker ) {
		case( 1850 ):
			unprotected_LED_blink( LED2 );
		  break;
		case( 2000 ) :
			ticker = 0;
			unprotected_LED_blink( LED2 );
		  break;
	}  // end switch
	
	// nothing more to do (yet) ... timed waiting and sleeping is not supported in this version
	
	os_KernelExitCriticalSection();
  return;	
}

/*! \fn void ScheduleContextSwitch(void)
    \brief Schedules a context switch

     Sets PendSV to pending.
*/
void ScheduleContextSwitch(void)
{
	SCB->ICSR |= SCB_ICSR_PENDSVSET_Msk; // Set PendSV to pending
	return;
}


// -------------------------------------------------------------------------
/*! 
    \brief Report HardFault when things goes wrong
    \note No need to disable interrupts since the fault handler is the second most important interrupt.
*/
__asm void HardFault_Handler(void) 
{
  TST    LR, #4
  ITE    EQ
  MRSEQ  R0, MSP
  MRSNE  R0, PSP
  B      __cpp(HardFault_Handler_C)
}	

/*!
    \brief C part of the handler

     Printing process ID, processes stacks and stacked PC
    
    \param svc_args Stack
*/
void HardFault_Handler_C(unsigned int * svc_args)
{
	//TWP: the macro should never be true ... major design revisions have made some code no longer valid 	
#if ((ENABLE_KERNEL_PRINTF) && (ENABLE_KERNEL_PRINTF == 1))	
	uint32_t i;
	
  printf("[HardFault]\n\r");
	printf("Environment:\n\r");
  printf ("curr_task = %d\n\r", curr_task);
	printf ("rtr_q_h = %d\n\r", rtr_q_h);
	for ( i = 0; i < 10 ; i++ )
	{
		printf ("PSP # %d = %x\n\r",i, PSP_array[i]);
	}
  printf ("Stacked PC = %x\n\r", svc_args[6]);
#endif	
  stop_cpu2;	
}
// -------------------------------------------------------------------------


