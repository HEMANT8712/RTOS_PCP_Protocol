/*! \file PCP_Semaphore1.c
		\details Contains PCP Resource semaphore 1 related API implementations. Defines the semaphore, and initializes it .
*/

//TWP:  stripped out tracing

#include "trace.h"
#include "osObjects.h"
#include "stdio.h"


osSemaphoreId Server1 = {0};                        ///< semaphore id
osSemaphoreDef (PCP_Semaphore1);                         ///< semaphore object

/*! \fn int Init_Semaphore0 (void) 
    \brief Initializing Semaphore0
		\return 0=successful; -1=failure
*/
int Init_PCP_Semaphore1 (void) 
{  //TWPV1 create with count = 0
  Server1 = osSemaphoreCreate(osSemaphore(PCP_Semaphore1), 1);
  if (!Server1)  {
		return (-1);
  }
	//Setting the Server1 Priority
	Server1->priority = osPriorityAboveNormal; 
	//Setting unique id for server
  Server1->resource_id = 1;                 
  printf("created pce_Sem1\n\r");	
  return(0);
}

/*! \fn int Delete_pce_Semaphore1 (void)  
    \brief Deleting pce_Semaphore1
    \return 0=successful; -1=failure
*/
int Delete_PCP_Semaphore1 (void) 
{
  if ( osSemaphoreDelete(Server1) != osOK)
	{
//TWP    if (addTrace("pce_Sem1 - could not delete") != TRACE_OK)
//TWP		{
//TWP			stop_cpu;
//TWP		}
		return (-1);
  } 
  return(0);
}
