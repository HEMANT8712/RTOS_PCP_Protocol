/*! \file PCP_Semaphore2.c
		\details Contains PCP Resource 2 related API implementations. Defines the semaphore, and initializes it .
*/

//TWP:  stripped out tracing

#include "trace.h"
#include "osObjects.h"
#include "stdio.h"
#include "RavenOS.h"
osSemaphoreId Server2 = {0};                        ///< semaphore id
osSemaphoreDef (PCP_Semaphore2);              ///< semaphore object

/*! \fn int Init_pce_Semaphore2 (void) 
    \brief Initializing Server2
		\return 0=successful; -1=failure
*/
int Init_PCP_Semaphore2 (void) 
{  //TWPV1 create with count = 0
  Server2 = osSemaphoreCreate(osSemaphore(PCP_Semaphore2), 1);
  if (!Server2)  {
		return (-1);
  }
	//Setting the Server2 Priority
	Server2->priority = osPriorityHigh;	
	// Setting Server 2 Unique ID
	Server2->resource_id = 2;           
  printf("created Server2\n\r");	
  return(0);
}

/*! \fn int Delete_pce_Semaphore2 (void)  
    \brief Deleting pce_Semaphore2
    \return 0=successful; -1=failure
*/
int Delete_PCP_Semaphore2 (void) 
{
  if ( osSemaphoreDelete(Server2) != osOK)
	{
//TWP    if (addTrace("pce_sem2 - could not delete") != TRACE_OK)
//TWP		{
//TWP			stop_cpu;
//TWP		}
		return (-1);
  } 
  return(0);
}
