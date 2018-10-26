/*! \file sem3.c
    \brief  LED Semaphore
		\details Contains semaphore 0 related API implementations. Defines the semaphore, and initializes it .
*/

//TWP:  stripped out tracing

#include "trace.h"
#include "osObjects.h"
#include "stdio.h"

osSemaphoreId sid_Semaphore3;                        ///< semaphore id
osSemaphoreDef (Semaphore3);                         ///< semaphore object

/*! \fn int Init_Semaphore0 (void) 
    \brief Initializing Semaphore0
		\return 0=successful; -1=failure
*/
int Init_Semaphore3 (void) 
{
  //TWPV1 create with count = 0
  sid_Semaphore3 = osSemaphoreCreate(osSemaphore(Semaphore3), 0);
  if (!sid_Semaphore3)  {
//TWP    if (addTrace("sem3 could not create") != TRACE_OK)
//TWP		{
//TWP			stop_cpu;
//		}
		return (-1);
  }
  printf("created sem3\n\r");	
  return(0);
}

/*! \fn int Delete_Semaphore3 (void)  
    \brief Deleting Semaphore3
    \return 0=successful; -1=failure
*/
int Delete_Semaphore3 (void) 
{
  if ( osSemaphoreDelete(sid_Semaphore3) != osOK)
	{
//TWP    if (addTrace("sem3 - could not delete") != TRACE_OK)
//TWP		{
//TWP			stop_cpu;
//TWP		}
		return (-1);
  } 
  return(0);
}
