/*! \file thread4.c
    \brief A thread that toggles the RED LED.
		\details Initialize and implement thread
*/

#include "peripherals.h" 
#include "osObjects.h"
#include "trace.h"
#include "stdio.h"

//TWP this creates an instance of a Thread Definition structure and generates a name for it that includes "thread4"
// TWP the striuct is initialized with pointer the thread4 function, High priority, and 300 byte stack
//osThreadDef (thread4, osPriorityHigh, 300);  ///< thread definition
#include "CU_TM4C123.h"                 // Device header
osThreadDef (thread4, osPriorityAboveNormal, 300);  ///< thread definition
//TWP just a variable for later use
osThreadId tid_thread4;          ///< thread4 id
extern osSemaphoreId sid_Semaphore1;
// just a prototype ... needed by thread4 function
void task0(void);

/*! \fn int Init_thread4 (void)
  \brief Initializing thread4
  */
int Init_thread4 (void) 
{
		//TWP osThread(thread4) defines a pointer value to the thread's Definition struct (resolves to the generated name)
    tid_thread4 = osThreadCreate (osThread(thread4), NULL);

    if (tid_thread4 == NULL) 
    {
        return(-1);
    }
    printf("created thread4\n\r");
    return(0);
}

/*! \fn int Terminate_thread4 (void) 
  \brief Terminating thread4
  \return 0=successful; -1=failure
  */
int Terminate_thread4 (void) 
{	

    if (osThreadTerminate(tid_thread4) != osOK)
    {
        return(-1);
    }

    return(0);
}

/*! \fn void thread4 (void const *argument)
  \brief Thread definition for thread 0.
  \param argument A pointer to the list of arguments.
  */
void thread4 (void const *argument) 
{   uint32_t i;
	  printf(" thread4 start with Above Normal priority\n");
    for ( i = 0; i < 5; i++ ) // while (1) 
    {	
			printf("thread4 acquiring semaphore 1 with count:%u\n\r",sid_Semaphore1->ownCount);
        if (osSemaphoreWait (sid_Semaphore1, osWaitForever) >= 0 ) 
        {                   				
					  printf("thread4 acquired semaphore 1\n\r");
   
            //Blink the red LED
            task0(); // thread code 
            count1Sec();
            task0();
            count1Sec();
            
 					  printf("thread4 releasing semaphore 1\n\r");
            if (osSemaphoreRelease (sid_Semaphore1) != osOK)
            {
                //Failed to release the semaphore
                printf("thread4 failed to release semaphore 1\n\r");
                stop_cpu;
            }
            //Released the semaphore
            printf("thread4 released semaphore 1\n\r");
        }
        else
        {
            //Failed to take the semaphore
            printf("thread4 failed to take semaphore 0\n\r");
            stop_cpu;
        }

        //Lower the priority
        //TWPV1  take these out for now ...
				// osThreadSetPriority(osThreadGetId(), osPriorityLow);
         //osThreadYield();  // suspend thread
    }
    
		osThreadSetPriority(tid_thread4, osPriorityLow);
    osThreadYield();  // suspend thread    
    printf("Demo Complete\n\r");          
		//TWPV1 ... just to shut the serial port and flashing LED off
		//stop_cpu;
}

// -------------------------------------------------------------------------
/*! \fn void task0(void)
  \brief Toggle LED #0
  */
void task0(void)
{ 
    protected_LED_blink(LED0);
}
