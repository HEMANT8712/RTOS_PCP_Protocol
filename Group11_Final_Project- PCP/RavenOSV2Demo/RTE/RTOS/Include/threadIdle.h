/*! \file threadIdle.h
    \brief This header file defines the Idle task related data
*/

#ifndef _THREADIDLE_H
#define _THREADIDLE_H

#include "RavenOS.h"

extern void threadIdle (void const *argument);
int Init_threadIdle (void) ;
extern osThreadId tid_threadIdle;

#endif
