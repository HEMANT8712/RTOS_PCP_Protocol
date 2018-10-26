/*! \file threads.c
    \brief This file defines thread implementation using the CMSIS interface
		\details Thread definition, creation and attributes manipulation.
*/

#include "RavenOS.h" 
#include "kernel.h"
#include "semaphores.h"
#include <stdlib.h>


// threads are managed in a dynamic linked list ... list modified only when a thread is created or removed
osThreadId thread_list_h = NULL;			///< head of thread list, list initially empty
uint32_t th_q_cnt = 0;        ///< Thread counter (number of threads in th_q)

osThreadId rtr_q_h = NULL;  ///< Ready to Run Queue Head, , RTRQ initially empty
uint32_t rtr_q_cnt = 0;        ///< Ready to Run Queue thread counter

// RTRQ manipulation functions
void osInsertRTRQ( os_tcb_p th );
void osRemoveRTRQ( os_tcb_p th );
osThreadId osGetRTRQHead(void);
// TODO: implement sleeping and waiting threads

// included for CMSIS compatibility, but ... deleting threads is not supported in this version
// TODO add support for removing threads
void os_ThreadRemoveThread(osThreadId thread_id);

/// Create a thread and add it to Active Threads and set it to state RUNNING.
/// \param[in]     thread_def    thread definition referenced with \ref osThread.
/// \param[in]     argument      pointer that is passed to the thread function as start argument.
/// \return thread ID for reference by other functions or NULL in case of error.
/// \note MUST REMAIN UNCHANGED: \b osThreadCreate shall be consistent in every CMSIS-RTOS.
/// \note RavenOS ignores the argument parameter
/// \note RavenOS uses threadDef struct as tcb ... removed "const" from thread_def parameter ... breaks CMSIS compatibility
/// \note If osThreadCreate called after kernel started, then created thread may start running before return from create call
osThreadId osThreadCreate ( osThreadDef_t *thread_def, void *argument)
{
	// the definition does not exist, nothing to feed from, so exiting
	if ( thread_def == NULL )
	{
		return NULL;
	}	
	
	// if there is a thread def present ... assume it is OK
	// check that the priority is whithin limits
	// TODO add min and max macros associated with level definitions rather than using specific levels
	if ( (thread_def->tpriority < osPriorityIdle) || (thread_def->tpriority > osPriorityRealtime) )
	{
		return NULL;
	}
	
	// Add the thread to the thread list ... add at head (easy)
	thread_def->th_list_p = thread_list_h;
	th_q_cnt++;
		
	thread_def->priority = thread_def->tpriority;  // initial run-time priority == initial priority
	thread_def->status   = TH_RUNNING;
	
	thread_def->semaphore_id = NULL;
	thread_def->timed_q_p   = NULL;
	thread_def->timed_ret   = osOK;
	thread_def->time_count  = 0;    /// Ready-to-Run	
	thread_def->rtr_q_p  = NULL;    /// no "next" thread ... not yet in RTRQ	
	
	// Need the &stack space, stack_size and the &start_p in order to set up initial stack frame
	//TWPV6: building of stack frame here   replaces	os_KernelStackAlloc(thread_def);	
	// stack was allocated in application space, base address in def_strct->stack_p    
	thread_def->stack_p = (uint8_t *) (((unsigned int) thread_def->stack_p) + (thread_def->stack_size) - 18*4);
	HW32_REG((thread_def->stack_p + (16<<2))) = (unsigned long) thread_def->start_p; // initial Program Counter
	HW32_REG((thread_def->stack_p + (17<<2))) = 0x01000000;            // initial xPSR
	HW32_REG((thread_def->stack_p          )) = 0xFFFFFFFDUL;          // initial EXC_RETURN
	HW32_REG((thread_def->stack_p + ( 1<<2))) = 0x3;// initial CONTROL : unprivileged, PSP		

	// put new thread in RTRQ
	osInsertRTRQ( thread_def );
	
	return thread_def;
}
	

// RTRQ manipulation functions

void rtrqWalk( void )
{
	// a debugging function ... only called to validate RTRQ contents using debugger
	// walk the RTRQ exposing contents
	os_tcb_p *checkHere;  // pointer to a RTRQ pointer/index
	for ( checkHere = &rtr_q_h; *checkHere != NULL; checkHere = &( (*checkHere)->rtr_q_p ) ) 
	{
		if( checkHere != NULL )   
		{
			continue;   // set breakpoint here to check contents
		}
		
	}
}


/// Priority insert thread into RTRQ
/// \param[in]     th    thread tcb pointer
/// \return        none
/// \note inserts the thread in front of the next lower priority thread, 
/// \note and before any threads of equal priority 
/// \note ensures that application thread at IdleThread priority is in RTRQ in front of IdleThread
void osInsertRTRQ( os_tcb_p th )
{
	os_tcb_p *checkHere;  // pointer to a RTRQ pointer
	// walk the RTRQ looking for the RTRQ pointer to modify
	for ( checkHere = &rtr_q_h; *checkHere != NULL; checkHere = &( (*checkHere)->rtr_q_p ) ) 
	{
		// this version inserts the thread in front of the next lower priority thread, and before any threads of equal priority
		// to insert after any threads of equal priority, change "<=" to "<"		
		if ( (*checkHere)->priority <= th->priority )
		{
			// found RTRQ pointer to modify!
			break;
		}
	}
	// checkHere points to the RTRQ pointer/index to be modified
	// save link to rest of list
	th->rtr_q_p = *checkHere;
	// insert the new thread here
	*checkHere = th;
	// record one more in RTRQ
	rtr_q_cnt++;
	
	// uncomment next line to enable       
	//rtrqWalk();  // just for debug
}


/// Remove thread from RTRQ. If thread not in RTRQ ... does not change RTRQ.
/// \param[in]     th    tcb pointer for thread to remove
/// \return        none
void osRemoveRTRQ( os_tcb_p th )
{
		os_tcb_p *checkHere;  // pointer to a RTRQ pointer
	// walk the RTRQ looking for the RTRQ pointer to modify
	for ( checkHere = &rtr_q_h; *checkHere != NULL; checkHere = &( (*checkHere)->rtr_q_p ) ) 
	{
		if ( *checkHere == th )
		{
			// found RTRQ pointer to modify!
			break;
		}
	}
	// checkHere points to the RTRQ pointer/index to be modified, or th was not in RTRQ
	if ( *checkHere != NULL )   // only remove if th is in list
	{
		// save link to rest of list
		*checkHere = th->rtr_q_p;
		// clear RTRQ pointer for thread ... just to be safe
		th->rtr_q_p = NULL;
		// record removal from RTRQ
		rtr_q_cnt--;
	}
	// uncomment next line to enable       
	//rtrqWalk();  // just for debug
}

/// Return the thread ID of the current running thread.
/// \return thread ID for reference by other functions or NULL in case of error.
/// \note MUST REMAIN UNCHANGED: \b osThreadGetId shall be consistent in every CMSIS-RTOS.
osThreadId osThreadGetId (void)
{
	return curr_task;
}

// TODO revise implementation to support removing threads
// TWP not used in this version ... thread removal is not supported 
/// Terminate execution of a thread and remove it from Active Threads.
/// \param[in]     thread_id   thread ID obtained by \ref osThreadCreate or \ref osThreadGetId.
/// \return status code that indicates the execution status of the function.
/// \note MUST REMAIN UNCHANGED: \b osThreadTerminate shall be consistent in every CMSIS-RTOS.
osStatus osThreadTerminate (osThreadId thread_id)
{
/* Original code removed due to major RavenOS redesign
*/	
	return osOK;
}

/// Pass control to next thread that is in state \b READY.
/// \return status code that indicates the execution status of the function.
/// \note MUST REMAIN UNCHANGED: \b osThreadYield shall be consistent in every CMSIS-RTOS.
osStatus osThreadYield (void)
{
	//invoke scheduler
	os_KernelInvokeScheduler ();
	
	return osOK;
}

/// Change priority of an active thread.
/// \param[in]     thread_id     thread ID obtained by \ref osThreadCreate or \ref osThreadGetId.
/// \param[in]     priority      new priority value for the thread 
/// \return status code that indicates the execution status of the function.
/// \note MUST REMAIN UNCHANGED: \b osThreadSetPriority shall be consistent in every CMSIS-RTOS.
/// \note also adjusts the position of the thread in RTRQ or semaphore Q if/when approariate
/// \note if adjusts RTRQ will also perform a context switch if necessary
osStatus osThreadSetPriority (osThreadId thread_id, osPriority priority)
{
	if (thread_id == NULL)
	{		
		return osErrorValue;
  }
  // TODO add a check on priority range (must be valid)
  thread_id->priority = priority;
	if (thread_id->status == TH_RUNNING)
	{
		// adjust in RTRQ
		osRemoveRTRQ( thread_id );
		osInsertRTRQ( thread_id );
		// may require a context switch!
		os_KernelInvokeScheduler();
	}	
	else
	{
			if (thread_id->status == TH_BLOCKED)
			{
				// adjust in RTRQ
				osRemoveBlockedQ( thread_id->semaphore_id, thread_id );
				osInsertBlockedQ( thread_id->semaphore_id, thread_id );
			}		
	}	
	
	return osOK;
}



/// Get current priority of an active thread.
/// \param[in]     thread_id     thread ID obtained by \ref osThreadCreate or \ref osThreadGetId.
/// \return current priority value of the thread function.
/// \note MUST REMAIN UNCHANGED: \b osThreadGetPriority shall be consistent in every CMSIS-RTOS.
osPriority osThreadGetPriority (osThreadId thread_id)
{
	if (thread_id == NULL)
	{		
		return osPriorityError;
  }
  
	return thread_id->priority;
}



// TODO revise for thread removal
// TWP not used in this version since thread removal is not supported 
/// Remove thread from all the lists.
/// \param thread_id  Thread ID of the thread to remove
// Original code removed following major revison of RavenOS design 
void os_ThreadRemoveThread(osThreadId thread_id)
{
/*
	// just park the thread in TH_DEAD state
	// this particular thread cannot be 'revived', it will be dead until the end of the program/forever
*/
	return;
}


osThreadId osGetRTRQHead(void)
{
	return (rtr_q_h);
}
