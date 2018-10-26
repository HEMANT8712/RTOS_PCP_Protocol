/*! \file thread2.c
    \brief A thread that toggles the BLUE LED.
		\details Initialize and implement thread
*/

#include "peripherals.h" 
#include "osObjects.h"
#include "trace.h"
#include "stdio.h"

osThreadDef (thread2, osPriorityBelowNormal, 1, 100);  ///< thread definition

osThreadId tid_thread2;                                ///< thread id
void task2(void);

/*! 
  \brief Initializing thread2
  */
int Init_thread2 (void) 
{
    tid_thread2 = osThreadCreate (osThread(thread2), NULL);
    if(!tid_thread2) return(-1);

    return(0);
}

/*!  
  \brief Terminating thread2
  */
int Terminate_thread2 (void) 
{	
    if (osThreadTerminate(tid_thread2) != osOK)
    {
        return(-1);
    }

    return(0);
}

/*! 
  \brief Thread definition for thread 2.
  \param argument A pointer to the list of arguments.
  */
void thread2 (void const *argument) 
{
    while (1)
    {
        if ( osSemaphoreWait (sid_Semaphore0, osWaitForever) != -1 ) // wait forever
        {
            //Blick blue LED
            task2(); // thread code
            count1Sec();
            task2();
            count1Sec();

            //Release the semaphore
            if (osSemaphoreRelease (sid_Semaphore0) != osOK)
            {
                //Failed to release the semaphore
                printf("thread2 failed to release the semaphore");
                stop_cpu;
            }
        }
        else
        {
            //Failed to take the semaphore
            printf("thread2 failed to get the semaphore");
            stop_cpu;
        }
        osThreadSetPriority(osThreadGetId(), osPriorityLow);

        osThreadYield();     	
    }

/*TWP
    // This should terminate the current thread2 thread		
    if (Terminate_thread2() != 0)
    {
        stop_cpu;		
    }
*/
		
}

// -------------------------------------------------------------------------
/*! 
  \brief Toggle LED #2
  */
void task2(void)
{ 
    LED_blink(LED2);
}
