/*! \file sem4.c
    \brief  LED Semaphore
		\details Contains semaphore 0 related API implementations. Defines the semaphore, and initializes it .
*/

//TWP:  stripped out tracing

#include "trace.h"
#include "osObjects.h"
#include "stdio.h"

osSemaphoreId sid_Semaphore4;                        ///< semaphore id
osSemaphoreDef (Semaphore4);                         ///< semaphore object

/*! \fn int Init_Semaphore4 (void) 
    \brief Initializing Semaphore4
		\return 0=successful; -1=failure
*/
int Init_Semaphore4 (void) 
{
  //TWPV1 create with count = 0
  sid_Semaphore4 = osSemaphoreCreate(osSemaphore(Semaphore4), 0);
  if (!sid_Semaphore4)  {
//TWP    if (addTrace("sem4 could not create") != TRACE_OK)
//TWP		{
//TWP			stop_cpu;
//		}
		return (-1);
  }
  printf("created sem4\n\r");	
  return(0);
}

/*! \fn int Delete_Semaphore4 (void)  
    \brief Deleting Semaphore4
    \return 0=successful; -1=failure
*/
int Delete_Semaphore4 (void) 
{
  if ( osSemaphoreDelete(sid_Semaphore4) != osOK)
	{
//TWP    if (addTrace("sem4 - could not delete") != TRACE_OK)
//TWP		{
//TWP			stop_cpu;
//TWP		}
		return (-1);
  } 
  return(0);
}
