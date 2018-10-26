/*! \file kernel.h
    \brief This header file defines all kernel related data
		\details Makes available the context switch API for threads.
*/

#ifndef _KERNEL_H
#define _KERNEL_H

#include <stdint.h>
#include "RavenOS.h"

/*! \def HW32_REG(ADDRESS) 
         Macros for word accesses. */
#define HW32_REG(ADDRESS)  (*((volatile unsigned long  *)(ADDRESS)))
	

void os_KernelInvokeScheduler (void);
void os_KernelStackAlloc (os_tcb_p thread_p);

//TWPV2
extern os_tcb_p curr_task;               ///< Current task
//TWPV6: removing next_task     extern os_tcb_p next_task;               ///< Next task

#endif

