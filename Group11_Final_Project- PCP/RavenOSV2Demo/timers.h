/*! \file GPTM_Ttimers.h
    \brief This header file defines all Timers related data
		\details Makes available the Timer  API for threads for calculation for Semaphore Time.
*/

#ifndef _TIMERS_H
#define _TIMERS_H

#include <stdint.h>

//*****************************************************************************
//
// Macros
//
//*****************************************************************************

#define TIMER_A                  0x000000ff  // Timer A
#define TIMER0_BASE              0x40030000  // Timer0
#define TIMER1_BASE              0x40031000  // Timer1
#define MAX_VALUE_ONE_SHOT_TIMER 0xFFFFFFFF //Max value of 32-bit one-shot timer
#define TIMER_O_TAV              0x00000050  // GPTM Timer A Value
#define TIMER_O_TBV              0x00000054  // GPTM Timer B Value


/*! Prototypes */

void Timer0_Init (void);  // Initialize Timer 0
 
void Timer1_Init (void);  // Initialize Timer 1

void Timer_Enable(uint32_t base, uint32_t timer); // Enable the Timer

void Timer_Disable(uint32_t base, uint32_t timer); // Disable the Timer

uint32_t Timer_Get_Value(uint32_t base, uint32_t timer); // Get the Timer Value

#endif

