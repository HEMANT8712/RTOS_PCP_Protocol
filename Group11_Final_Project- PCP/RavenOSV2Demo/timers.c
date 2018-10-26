//*****************************************************************************
//
// timers.c - Using Timers .
//
// Copyright (c) 2012-2017 Texas Instruments Incorporated.  All rights reserved.
// Software License Agreement
//
// This is part of revision 2.1.4.178 of the EK-TM4C123GXL Firmware Package.
//
//*****************************************************************************
#include <stdint.h>
#include <stdbool.h>
#include "inc/hw_types.h"
#include "driverlib/rom.h"
#include "driverlib/sysctl.h"
#include "driverlib/timer.h"
#include "timers.h"

//Global Variable for Overhead Mearurement
uint32_t Problem1_tick = 0;
uint32_t Problem2_tick = 0;
uint32_t Problem3_tick = 0;
uint32_t Problem4_tick = 0;
uint32_t Problem5_tick = 0;

//*********************************************************************************
//
// Timer1 Initialization : Used to measure the clockticks taken when:-
// 1. When osSemaphoreWait is called with sid_Semaphore1 which is initialize with
//    count 1 in the AboveNormal Priority Thread1 and get the semaphore and decrease
//    count to 0.
//
// 3. When osSemaphoreRelease is called with sid_Semaphore1 which release the 
//    semaphore 1 and now count is 1 in the AboveNormal Priority Thread1 and Thread 0 
//    is still bloacked on Semaphore 0 whose count is 0.
//  
// 4. When osSemaphoreRelease is called with sid_Semaphore0 in the AboveNormal   
//    Priority Thread1 which release the semaphore 0 and now count is 1 for Semaphore0 
//    and High Priority Thread 0 moves to Ready to Run queue from blocked queue  
//    and context switches from Thread 1 to Thread 0 due to less priority of Thread 1
//    and when again Thread 0 get blocked again Thread 1 continues its execution.
//
//***********************************************************************************
void Timer1_Init(void)
{    
    //
    //Set the clocking to run directly from the crystal.
    //Function configures the clocking of the device.  The input crystal
    //frequency, oscillator to be used, use of the PLL, and the system clock
    //divider are all configured with this function.
    //This function should only be called on TM4C123 devices.
    //
    // The system clock divider is chosen with value SYSCTL_SYSDIV_1
    // The use of the PLL is chosen with SYSCTL_USE_OSC.
    // The external crystal frequency is chosen with  SYSCTL_XTAL_16MHZ,
    // The oscillator source is chosen with value SYSCTL_OSC_MAIN

    ROM_SysCtlClockSet(SYSCTL_SYSDIV_1 | SYSCTL_USE_OSC | SYSCTL_OSC_MAIN |
                     SYSCTL_XTAL_16MHZ);

    // Enable the peripherals used in this assignment for Timer 1.

    ROM_SysCtlPeripheralEnable(SYSCTL_PERIPH_TIMER1);

    // Reset the peripherals used in this assignment for Timer 1.

    ROM_SysCtlPeripheralReset(SYSCTL_PERIPH_TIMER1);

    // Configure the 32-bit One-Shot timer in UP Count mode.

    ROM_TimerConfigure(TIMER1_BASE, TIMER_CFG_ONE_SHOT_UP);

    //Load the Max value into the GPTM Timer A Interval Load Register till which timer runs.

    ROM_TimerLoadSet(TIMER1_BASE, TIMER_A, MAX_VALUE_ONE_SHOT_TIMER);

}

//*******************************************************************
//
// Timer_Enable:- Function is used to enable Timers
//
// Input:- base- Base Register Value for Timers
//         timer- Type of timer going to use
//
// Output:- void
//*******************************************************************

void Timer_Enable(uint32_t base, uint32_t timer) 
{
	//Disable the timer enable bit
    ROM_TimerDisable(base, timer);
	//
    //Important Note:-
    //Reset the timers by disabling it and setting the GPTMTAV register to 0.
    //Clearing the timer enable bit (by calling the TimerDisable()
    //function also does NOT clear the timer.There are two Timer value
    //registers.  One of these registers is a read-only register (GPTMTAR),
    //and is the value that is returned by the TimerValueGet() API.
    //The second register is a read-write register (GPTMTAV),
    //and is not exposed in the Timer API (therefore need to reset it explicitly).
    //When the TAV register is written, the TAR register is updated on the next clock cycle.
    //
    
    //Resetting the Timer  GPTMTAV register
    HWREG(base + TIMER_O_TAV) = 0;

    //Enable Timer A in Timer 0
    ROM_TimerEnable(base, timer);
}

//*******************************************************************
//
// Timer_Disable:- Function is used to disable Timers
//
// Input:- base- Base Register Value for Timers
//         timer- Type of timer going to use
//
// Output:- void
//*******************************************************************

void Timer_Disable(uint32_t base, uint32_t timer) 
{
   //Disable the timer enable bit
    ROM_TimerDisable(base, timer);
}


//*******************************************************************
//
// Timer_Get_Value:- Function is used to get Timers Value
//
// Input:- base- Base Register Value for Timers
//         timer- Type of timer going to use
//
// Output:- uint32_t:- Number of ticks in Timer register Value
//*******************************************************************

uint32_t Timer_Get_Value(uint32_t base, uint32_t timer)
{	 
	//Capturing the value of timer after the loop ends
    return(ROM_TimerValueGet(base,timer));
}
