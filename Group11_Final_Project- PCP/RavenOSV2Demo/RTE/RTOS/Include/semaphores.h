
#ifndef _SEMAPHORES_H
#define _SEMAPHORES_H

#include "RavenOS.h"

// prtotypes for access to semaphore blocked Qs
void osInsertBlockedQ( osSemaphoreId semaphore_id, os_tcb_p th_p );
void osRemoveBlockedQ( osSemaphoreId semaphore_id, os_tcb_p th_p );
	
#endif
