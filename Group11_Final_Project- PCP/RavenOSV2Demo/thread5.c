/*! \file thread5.c
    \brief A thread that runs with priority "Low".
		\details Initialize and implement thread
*/

//TWP replaced with Darren's version

#include "peripherals.h" 
#include "osObjects.h"
#include "trace.h"
#include "stdio.h"
#include "timers.h"

osThreadDef (thread5, osPriorityLow, 500);  ///< thread definition

osThreadId tid_thread5;     ///< thread id


/*! 
  \brief Initializing thread5
  */
int Init_thread5 (void) 
{
    tid_thread5 = osThreadCreate (osThread(thread5), NULL);
    if(!tid_thread5) return(-1);

    return(0);
}

/*!  
  \brief Terminating thread5
  */
int Terminate_thread5 (void) 
{	
    if (osThreadTerminate(tid_thread5) != osOK)
    {
        return(-1);
    }

    return(0);
}

/*! 
  \brief Thread definition for thread 5.
  \param argument A pointer to the list of arguments.
  */
void thread5 (void const *argument) 
{	
	int i = 0;//Variable for Loop Maintaince
		  
	while (i<1) //Loop for Execution
  {	
			i++;

      printf(" Task5: Hello!\n\r");
					  
			printf("Task5: Locking Server1 ! with priority %d\n\r", Server1->priority);
      
		  //Enable Timer A in Timer 1 to measure time taken by PCP semaphore in
			//Wait when Thread 5 is not in blocked state
   			Timer_Enable(TIMER1_BASE, TIMER_A);
					
		  //Task 5 locking Server 1		
		  if (PCP_Semaphore_Wait (Server1, osWaitForever) >= 0 )
			{
         //Capturing the value of timer when Thread 5 acquire
         //PCP Server1 when Thread 5 not in bloacked state
					Problem1_tick = Timer_Get_Value(TIMER1_BASE, TIMER_A);
						
				 //Disable Timer A of Timer 1
					Timer_Disable(TIMER1_BASE, TIMER_A);				
				 printf("Task5: Server1 Locked ! \n\r");

   			 printf("Task5:Elevates Current Ceiling Priority of System to Server 1 i.e. Task2\n\r");	
							
				 printf("Task5: Performing Some Work ! \n\r");
				 printf("Releasing Task4\n\r");
		 	   //Unlocking Task 4 !! 						
				 if (osSemaphoreRelease (sid_Semaphore4) != osOK)
         {
             printf("thread5 failed to release semaphore 0\n\r");
             stop_cpu;
         }
         //Capturing the value of timer after Thread 4 blocked
         //on PCP Server 2 and context switch to thread 5	
			   Problem5_tick = Timer_Get_Value(TIMER1_BASE, TIMER_A);
			   //Disable Timer A of Timer 0
			   Timer_Disable(TIMER1_BASE, TIMER_A);

				  printf("Task5:Priority Elevates to Task4\n\r");
        
  				printf("Releasing Task3\n\r");
	
 				  
				 //Unlocking Task 3 !!	
	 	  	 if (osSemaphoreRelease (sid_Semaphore3) != osOK)
         {
             printf("thread5 failed to release semaphore 3\n\r");
             stop_cpu;
         }
         //Capturing the value of timer after Thread 2 blocked
         //on PCP Server 1 and context switch to thread 5	
			   Problem2_tick = Timer_Get_Value(TIMER1_BASE, TIMER_A);
			   //Disable Timer A of Timer 0
			   Timer_Disable(TIMER1_BASE, TIMER_A);
   	 				
				 printf("Task5:Priority Elevates to Task2\n\r");
         
          //Unblocking Task 1 !!
				  printf("Releasing Task1\n\r");
				  if (osSemaphoreRelease (sid_Semaphore1) != osOK)
          {
              printf("thread5 failed to release semaphore 1\n\r");
              stop_cpu;
          }
					printf("Task5: Unlocking Server 1 !\n\r");
          printf("Task5:Moves Current Ceiling Priority of System to Original Priority\n\r");					
				  printf("Task5:Moves to Original Priority\n\r");			

            //Enable Timer A in Timer 1 to measure time taken by PCP semaphore in
			      // release when after release of Server 1, Thread 2 moves from 
					  // blocked state to ready to run state and start execution
					  // Thread 5 Execution put on hold and resumes again all high
						// priority thread are in blocked state again
   			    
					Timer_Enable(TIMER1_BASE, TIMER_A);
										
					if (PCP_Semaphore_Release (Server1) != osOK)
          {
							printf("Task5: failed to release semaphore 0!\n\r");
                stop_cpu;
          }
				 
		  }
      else
      {
			 	printf("Task5 failed to acquire Server 1\n\r");
        stop_cpu;
			}	
			//Task 5 Work Complete
      printf("Task5: Bye! \n\r");
	    
			printf("\nTime Taken for Case1:(Wait on a PCP semaphore when the caller is not blocked)\n\r");
   		printf("Thread 5 with Server1 no blocking: %u\n\r",Problem1_tick);
			
			printf("\nTime Taken for Case2:(Wait on a semaphore when the caller is blocked)\n\r");
			printf("Thread 2 blocked with Server1, context switch to thread 5: %u\n\r",Problem2_tick);
			
			printf("\nTime Taken for Case3:(Signal (Release) a semaphore when the signal does not release a blocked thread)\n\r");
			printf("Thread 2 release Server1 and didnot release blocked thread 4: %u\n\r",Problem3_tick);
			
			printf("\nTime Taken for Case4:(Signal (Release) a semaphore when the signal does release a thread)\n\r");
			printf("Thread 5 release Server1 which release thread 2 context switch to thread2: %u\n\r",Problem4_tick);
			
      printf("\nTime Taken for Case5:(Wait on semaphore when caller is block even when resource is available)\n\r");
			printf("Thread 4 blocked with Server2, thread 4 context switch to thread5: %u\n\r",Problem5_tick);
						
			stop_cpu;		  					
    }//End of Loop 
       
	}
