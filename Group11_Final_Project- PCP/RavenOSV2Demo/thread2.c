/*! \file thread2.c
    \brief A thread which runs with priority Above Normal.
		\details Initialize and implement thread
*/

//TWP replaced with Darren's version

#include "peripherals.h" 
#include "osObjects.h"
#include "trace.h"
#include "stdio.h"
#include "timers.h"

osThreadDef (thread2, osPriorityAboveNormal, 500);  ///< thread definition

osThreadId tid_thread2;     ///< thread id


/*! 
  \brief Initializing thread1
  */
int Init_thread2 (void) 
{
    tid_thread2 = osThreadCreate (osThread(thread2), NULL);
    if(!tid_thread2) return(-1);

    return(0);
}

/*!  
  \brief Terminating thread1
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
  \brief Thread definition for thread 1.
  \param argument A pointer to the list of arguments.
  */
void thread2 (void const *argument) 
{	
	
  //Loop for Execution	
	while (1) 
    {	
			
        // BLocking Task 2 with Sem2 to achieve execution Behaviour
        if (osSemaphoreWait (sid_Semaphore2, osWaitForever) >= 0 )
        {
					printf(" Task2: Hello!\n\r");
          
			   	printf("Task2: Locking Server1 ! \n\r");

				//Enable Timer A in Timer 1 to measure time taken by PCP semaphore in
			  //Wait when Thread 2 is in blocked state 
			
					Timer_Enable(TIMER1_BASE, TIMER_A);
			  // Thread 2 tries to acquire Server 1 which is at count = 0 due to thread 5
			  // and moves thread 2 from Ready to run Queue to Blocked Queue
        								 
					// Task 2 acquiring for Server 1
					if (PCP_Semaphore_Wait (Server1, osWaitForever) >= 0 )
					{
						//Capturing the value of Context switch when Thread 2
            //releases from blocked state due to Server 1 is released in Thread 5			
					  Problem4_tick = Timer_Get_Value(TIMER1_BASE, TIMER_A);
					  //Disable Timer A of Timer 1
					  Timer_Disable(TIMER1_BASE, TIMER_A);
				
						//Task 2 acquired Server 1
					  printf("Task2: Server1 Locked ! \n\r");
						printf("Task2:Elevates Current Ceiling Priority of System to Server 1 i.e. Task2\n\r"); 
					  printf("Task2: Performing Some Work ! \n\r");
						
            printf("Task2: Unlocking Server 1 !\n\r");
						//Enable Timer A in Timer 1 to measure time taken by PCP semaphore in
			      // release when after release of Server 1, threads remain in blocked state  
					  
						 Timer_Enable(TIMER1_BASE, TIMER_A);
						
						// Task 2 Releasing Server 1
					  if (PCP_Semaphore_Release (Server1) != osOK)
            {
							printf("Task2: failed to release Server 1!\n\r");
                stop_cpu;
            }
						//Server 1 which didnot release any Thread from blocked state
 					  
					  Problem3_tick = Timer_Get_Value(TIMER1_BASE, TIMER_A);
					 	
						//Disable Timer A of Timer 1
					  Timer_Disable(TIMER1_BASE, TIMER_A);
						
						printf("Task2:Moves Current Ceiling Priority of System to Original Priority\n\r");	
					}
          else
          {
						printf("Task2: failed to acquire Server 1\n\r");
            stop_cpu;
					}	
          				  					
        }
        else
        {
            printf("thread2 failed to acquire semaphore 2\n\r");
            stop_cpu;
        }
				//Task2 works Completed
				printf("Task2: Bye! \n\r");
		
    }//End of While Loop
}

