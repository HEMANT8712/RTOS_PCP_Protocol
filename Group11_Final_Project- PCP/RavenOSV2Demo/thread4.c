/*! \file thread4.c
    \brief A thread which runs with Below Nolmal Priority.
		\details Initialize and implement thread
*/

#include "peripherals.h" 
#include "osObjects.h"
#include "trace.h"
#include "stdio.h"
#include "timers.h"

osThreadDef (thread4, osPriorityBelowNormal, 500);  ///< thread definition
//TWP just a variable for later use
osThreadId tid_thread4;          ///< thread4 id

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
  \brief Thread definition for thread 4.
  \param argument A pointer to the list of arguments.
  */
void thread4 (void const *argument) 
{     
	while (1) //Loop for Execution
    {	
		    // BLocking Task 4 with Sem4 to achieve execution Behaviour
        if (osSemaphoreWait (sid_Semaphore4, osWaitForever) >= 0 )					
        {
					
					printf(" Task4: Hello!\n\r");
  		    printf("Task4: Locking Server2! \n\r");
			    //Enable Timer A in Timer 1 to measure time taken by PCP semaphore in
		    	//Wait when Thread 4 got blocked even when resource is available 
   			  Timer_Enable(TIMER1_BASE, TIMER_A);			 		
      		// Task 4 acquiring for Server 2
					if (PCP_Semaphore_Wait (Server2, osWaitForever) >= 0 )
					{
						//Task 4 acquired Server 2
					  printf("Task4: Server2 Locked ! \n\r");
						
					  printf("Task4:Elevates Current Ceiling Priority of System to Server 2 i.e. Task1\n\r");	
						printf("Task4: Performing Some Work ! \n\r");
						printf("Task4: Locking Server1! \n\r");
						// Task 4 acquiring for Server 1
						if (PCP_Semaphore_Wait (Server1, osWaitForever) >= 0 )
						{
							// Task 4 acquired for Server 1
							printf("Task4: Server1 Locked ! \n\r");
						
							//Task 4 priority is equivalent to ceiling priority of the system
							//Therefore Task4 is able to locked on Server 1
							printf("Task4: Performing Some Work ! \n\r");
						
							printf("Task4: Unlocking Server 1 !\n\r");
							// Task 4 Releasing Server 1
							if (PCP_Semaphore_Release (Server1) != osOK)
							{
									printf("Task4: failed to release Server 1!\n\r");
									stop_cpu;
							}
							
						}
						else
						{
							printf("Task4: failed to acquire Server 1\n\r");
							stop_cpu;
						}	
					  
            printf("Task4: Unlocking Server 2 !\n\r");
						
						// Task 4 Releasing Server 2
						if (PCP_Semaphore_Release (Server2) != osOK)
            {
							printf("Task4: failed to release Server 2!\n\r");
                stop_cpu;
            }
						
						printf("Task4:Moves Current Ceiling Priority of System to Original Priority\n\r");
					}
          else
          {
						printf("Task4: failed to acquire Server 1\n\r");
            stop_cpu;
					}	
					//Task4 works Completed
          printf("Task4: Bye! \n\r");
					  					
        }
        else
        {
            printf("thread4 failed to acquire semaphore 0\n\r");
            stop_cpu;
        }
		
    }//End of While Loop
}
