/*! \file thread3.c
    \brief A thread which runs with Normal priority.
		\details Initialize and implement thread
*/

#include "trace.h"
#include "osObjects.h"
#include "stdio.h"

 
osThreadDef (thread3, osPriorityNormal, 500);///< thread definition
osThreadId tid_thread3;   ///< thread3 id


/*! 
    \brief Initializing thread 3
		\return 0=successful; -1=failure
*/
int Init_thread3 (void) 
{
	if (addTrace("thread3 init") != TRACE_OK)
	{
		stop_cpu;
	}	
	
  tid_thread3 = osThreadCreate (osThread(thread3), NULL);
  if(!tid_thread3) return(-1);

  return(0);
}

/*!  
    \brief Terminating thread3
		\return 0=successful; -1=failure
*/
int Terminate_thread3 (void) 
{	
	dumpTraceProtected();
	
	if (osThreadTerminate(tid_thread3) != osOK)
	{		
		return(-1);
	}		
  return(0);
}

/*! 
    \brief Thread definition for thread 3.
    \param argument A pointer to the list of arguments.
*/
/*! 
  \brief Thread definition for thread 3.
  \param argument A pointer to the list of arguments.
  */
void thread3 (void const *argument) 
{	
	//Loop for Execution		  
	while (1) 
    {	
        // Blocking Task 3 with Sem3 to achieve execution Behaviour
        if (osSemaphoreWait (sid_Semaphore3, osWaitForever) >= 0 )
        {
					printf(" Task3: Hello!\n\r");
		      printf("Releasing Task2\n\r");
				  //Unblocking Task 2 !!
				  if (osSemaphoreRelease (sid_Semaphore2) != osOK)
          {
              printf("thread5 failed to release semaphore 2\n\r");
              stop_cpu;
          }
				 
					
			    printf("Task3: Performing Some Work ! \n\r");  	
					
          //Task3 works Completed  					
          printf("Task3: Bye! \n\r");
					  					
        }
        else
        {
            printf("thread3 failed to acquire semaphore 3\n\r");
            stop_cpu;
        }
			
    }//End of While Loop
}

// -------------------------------------------------------------------------

