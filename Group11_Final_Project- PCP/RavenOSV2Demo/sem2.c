/*! \file sem2.c
    \brief  LED Semaphore
		\details Contains semaphore 0 related API implementations. Defines the semaphore, and initializes it .
*/

//TWP:  stripped out tracing

#include "trace.h"
#include "osObjects.h"
#include "stdio.h"

osSemaphoreId sid_Semaphore2;                        ///< semaphore id
osSemaphoreDef (Semaphore2);                         ///< semaphore object

/*! \fn int Init_Semaphore0 (void) 
    \brief Initializing Semaphore0
		\return 0=successful; -1=failure
*/
int Init_Semaphore2 (void) 
{
  //TWPV1 create with count = 0
  sid_Semaphore2 = osSemaphoreCreate(osSemaphore(Semaphore2), 0);
  if (!sid_Semaphore2)  {
//TWP    if (addTrace("sem2 could not create") != TRACE_OK)
//TWP		{
//TWP			stop_cpu;
//		}
		return (-1);
  }
  printf("created sem2\n\r");	
  return(0);
}

/*! \fn int Delete_Semaphore2 (void)  
    \brief Deleting Semaphore2
    \return 0=successful; -1=failure
*/
int Delete_Semaphore2 (void) 
{
  if ( osSemaphoreDelete(sid_Semaphore2) != osOK)
	{
//TWP    if (addTrace("sem2 - could not delete") != TRACE_OK)
//TWP		{
//TWP			stop_cpu;
//TWP		}
		return (-1);
  } 
  return(0);
}
