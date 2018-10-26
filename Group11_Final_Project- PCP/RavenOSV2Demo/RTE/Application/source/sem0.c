/*! \file sem0.c
    \brief  LED Semaphore
		\details Contains semaphore 0 related API implementations. Defines the semaphore, and initializes it .
*/

//TWP:  stripped out tracing

#include "trace.h"
#include "osObjects.h"
#include "stdio.h"

osSemaphoreId sid_Semaphore0;                        ///< semaphore id
osSemaphoreDef (Semaphore0);                         ///< semaphore object

/*! \fn int Init_Semaphore0 (void) 
    \brief Initializing Semaphore0
		\return 0=successful; -1=failure
*/
int Init_Semaphore0 (void) 
{
  //TWPV1 create with count = 0
  sid_Semaphore0 = osSemaphoreCreate(osSemaphore(Semaphore0), 0);
  if (!sid_Semaphore0)  {
//TWP    if (addTrace("sem0 could not create") != TRACE_OK)
//TWP		{
//TWP			stop_cpu;
//		}
		return (-1);
  }
  printf("created sem0\n\r");	
  return(0);
}

/*! \fn int Delete_Semaphore0 (void)  
    \brief Deleting Semaphore0
    \return 0=successful; -1=failure
*/
int Delete_Semaphore0 (void) 
{
  if ( osSemaphoreDelete(sid_Semaphore0) != osOK)
	{
//TWP    if (addTrace("sem0 - could not delete") != TRACE_OK)
//TWP		{
//TWP			stop_cpu;
//TWP		}
		return (-1);
  } 
  return(0);
}
