/*! \file sem1.c
    \brief UART Semaphore
		\details Contains semaphore 1 related API implementations. Defines the semaphore, and initializes it .
*/

//TWP: stripped out tracing

#include "trace.h"
#include "osObjects.h"
#include "stdio.h"

osSemaphoreId sid_Semaphore1;                        ///< semaphore id
osSemaphoreDef (Semaphore1);                         ///< semaphore object

/*! 
    \brief Initializing Semaphore
		\return 0=successful; -1=failure
*/
int Init_Semaphore1 (void) 
{
  //TWPV1 create with count = 1
	sid_Semaphore1 = osSemaphoreCreate(osSemaphore(Semaphore1), 0);
  if (!sid_Semaphore1)  {
//TWP    if (addTrace("sem1 could not create") != TRACE_OK)
//TWP		{
//TWP			stop_cpu;
//TWP		}
		return (-1);
  } 
	printf("created sem1\n\r");
  return(0);
}

/*!  
    \brief Deleting Semaphore
    \return 0=successful; -1=failure
*/
int Delete_Semaphore1 (void) 
{
  if ( osSemaphoreDelete(sid_Semaphore1) != osOK)
	{
 //TWP   if (addTrace("sem1 - could not delete") != TRACE_OK)
//TWP		{
//TWP			stop_cpu;
//TWP		}
		return (-1);
  } 
  return(0);
}
