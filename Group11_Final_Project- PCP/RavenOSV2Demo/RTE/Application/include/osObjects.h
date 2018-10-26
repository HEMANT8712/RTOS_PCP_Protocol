/*! \file osObjects.h
    \brief This header file defines all objects when included in a C/C++ source file
		\details Defines the stop_cpu as a breakpoint, threads, semaphores.
**/

#ifndef _OSOBJECTS_H
#define _OSOBJECTS_H

#include "RavenOS.h"                                   // CMSIS RTOS header file

/*! \def stop_cpu2
     Use Breakpoint to stop when error is detected (KEIL MDK specific intrinsic) */
/*! \def stop_cpu
     Stop when error is detected - while(1) version */
#define stop_cpu  while(1) {	}
#define stop_cpu2 __breakpoint(0)

//Global Variable for Overhead Mearurement
extern uint32_t Problem1_tick;
extern uint32_t Problem2_tick;
extern uint32_t Problem3_tick;
extern uint32_t Problem4_tick;
extern uint32_t Problem5_tick;



/// Thread definition
extern osThreadId tid_thread0;
extern void thread0 (void const *argument);             
int Init_thread0 (void);
int Terminate_thread0 (void);

extern osThreadId tid_thread1;
extern void thread1 (void const *argument);             
int Init_thread1 (void);
int Terminate_thread1 (void);

extern osThreadId tid_thread2;
extern void thread2 (void const *argument);             
int Init_thread2 (void);
int Terminate_thread2 (void);

extern osThreadId tid_thread3;
extern void thread3 (void const *argument);             
int Init_thread3 (void);
int Terminate_thread3 (void);

extern osThreadId tid_thread4;
extern void thread4 (void const *argument);             
int Init_thread4 (void);
int Terminate_thread4 (void);

extern osThreadId tid_thread5;
extern void thread5 (void const *argument);             
int Init_thread5 (void);
int Terminate_thread5 (void);

/// Semaphore definition

extern osSemaphoreId sid_Semaphore1;
int Init_Semaphore1 (void);
int Delete_Semaphore1 (void);

extern osSemaphoreId sid_Semaphore2;
int Init_Semaphore2 (void);
int Delete_Semaphore2 (void);

extern osSemaphoreId sid_Semaphore3;
int Init_Semaphore3 (void);
int Delete_Semaphore3 (void);

extern osSemaphoreId sid_Semaphore4;
int Init_Semaphore4 (void);
int Delete_Semaphore4 (void);

extern osSemaphoreId Server1;
int Init_PCP_Semaphore1 (void);
int Delete_PCP_Semaphore1 (void);

extern osSemaphoreId Server2;
int Init_PCP_Semaphore2 (void);
int Delete_PCP_Semaphore2 (void);


#endif // _OSOBJECTS_H
