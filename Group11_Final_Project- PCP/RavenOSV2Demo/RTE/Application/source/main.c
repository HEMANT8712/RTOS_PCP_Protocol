/*! \file main.c
    \brief A program that demonstrates threads
		\details Initialize threads and start the OS
**/


//TWP: fixed osObjectsExternal definition  (added "s" to "Objects")
#define osObjectsExternal                    // define objects in main module
#include "osObjects.h"                      // RTOS object definitions
#include "peripherals.h"                    // Peripheral definitions
#include "stdio.h"
#include "timers.h"
// -------------------------------------------------------------------------
/*! \fn int main(void)
    \brief Start of main program
		\details Initializes the peripherals and starts the OS
*/
int main(void)
{
	osKernelInitialize ();                    // initialize CMSIS-RTOS
	
	// initialize peripherals
	UART_initialize();
  printf("\n\rProject PCP: RavenOS Demo Version 2  (Dec 11, 2017)\n\r");
  LED_initialize(); 

	printf("Timer Initialize\n\r");

 	Timer1_Init();

	printf("Initializing thread1, thread2, thread3, thread4, thread5\n\r");
  
	//Creating Thread1;
	if (Init_thread1() != 0)
	{
		stop_cpu;
	}
	
	//Creating Thread2;
	if (Init_thread2() != 0)
	{
		stop_cpu;
	}
	
	//Creating Thread3;
	if (Init_thread3() != 0)
	{
		stop_cpu;
	}
	
	//Creating Thread4;
	if (Init_thread4() != 0)
	{
   	stop_cpu;
	}
	
	//Creating Thread5;
	if (Init_thread5() != 0)
	{
		stop_cpu;
	}
  printf("All threads initialized successfully\n\r");
	//TWP   V1 only uses thread0 & thread1
	/*
	if (Init_thread2() != 0)
	{
		stop_cpu;
	}
  */	
//  // thread3 is a low priority thread can be used as a more user obvious alternative to print tracing from UART, 
//  // which currently resides in the Idle thread (operated by the RTOS)
//  if (Init_thread3() != 0)
//	{
//		stop_cpu;
//	}
	
	printf("Initializing semaphores Sem1, Sem2, Sem3, Sem4\n\r");
  //Creating Sem1
	if (Init_Semaphore1() != 0)
	{
		stop_cpu;
	}	
  
	//Creating Sem2
	if (Init_Semaphore2() != 0)
	{
		stop_cpu;
	}	
  //Creating Sem3
	if (Init_Semaphore3() != 0)
	{
		stop_cpu;
	}
  //Creating sem4
	if (Init_Semaphore4() != 0)
	{
		stop_cpu;
	}		
	printf("All Semaphores initialized successfully\n\r");
  printf("creating PCP Resource Server1\n\r");
	if (Init_PCP_Semaphore1() != 0)
	{
		stop_cpu;
	}	
  printf("creating PCP Resource Server2\n\r");
	if (Init_PCP_Semaphore2() != 0)
	{
		stop_cpu;
	}	
  
	printf("Start kernel\n\r");
	osKernelStart ();                         // start thread execution 
	
  // Should never be here
	printf("Trouble -- returned from osKernelStart()\n\r");
  stop_cpu2;
}
