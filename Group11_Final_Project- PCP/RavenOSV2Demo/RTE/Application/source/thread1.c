/*! \file thread1.c
    \brief A thread which runs with High Priority.
		\details Initialize and implement thread
*/

//TWP replaced with Darren's version

#include "peripherals.h" 
#include "osObjects.h"
#include "trace.h"
#include "stdio.h"
#include "timers.h"
#include "RTE_Components.h"             // Component selection

osThreadDef (thread1, osPriorityHigh, 500);  ///< thread definition

osThreadId tid_thread1;     ///< thread id

/*! 
  \brief Initializing thread1
  */
int Init_thread1 (void) 
{
    tid_thread1 = osThreadCreate (osThread(thread1), NULL);
    if(!tid_thread1) return(-1);

    return(0);
}

/*!  
  \brief Terminating thread1
  */
int Terminate_thread1 (void) 
{	
    if (osThreadTerminate(tid_thread1) != osOK)
    {
        return(-1);
    }

    return(0);
}

/*! 
  \brief Thread definition for thread 1.
  \param argument A pointer to the list of arguments.
  */
void thread1 (void const *argument) 
{	
		  
	while (1) 
    {	
			  // BLocking Task 1 with Sem1 to achieve execution Behaviour    
        if (osSemaphoreWait (sid_Semaphore1, osWaitForever) >= 0 )
        {
					printf(" Task1: Hello!\n\r");
					  
					printf("Task1: Locking Server2 ! \n\r");
					
					// Task 1 acquiring for Server 2 
					if (PCP_Semaphore_Wait (Server2, osWaitForever) >= 0 )
					{
						//Task 1 acquired Server 2
					  printf("Task1: Server2 Locked ! \n\r");
            printf("Task1:Elevates Current Ceiling Priority of System to Server 2 i.e. Task1\n\r");						
					  printf("Task1: Performing Some Work ! \n\r");
						
						// Task 1 Releasing Server 2
            printf("Task1: Unlocking Server 2 !\n\r");
												
					  if (PCP_Semaphore_Release (Server2) != osOK)
            {
							printf("Task1: failed to release semaphore 0!\n\r");
                stop_cpu;
            }
						printf("Task1:Moves Current Ceiling Priority of System to Server 1 i.e. Task2\n\r");
				  
					}
          else
          {
						printf("Task1 failed to acquire Server 2\n\r");
            stop_cpu;
					}	
					//Task1 works Completed
          printf("Task1: Bye! \n\r");
					  					
        }
        else
        {
            printf("thread1 failed to acquire semaphore 1\n\r");
            stop_cpu;
        }
    }// End of While Loop
}
