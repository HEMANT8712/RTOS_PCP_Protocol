/*! \file peripherals.c
    \brief Implements peripheral level operations.
	  \details UART operations use CMSIS Driver interface. LED operations use direct hardware access.
*/

#include <stdbool.h>
#include "USART_TM4C123.h"
#include "peripherals.h"

#define LED_RED                GPIO_PIN_1   ///< Map the \a red LED to hardware pin 1
#define LED_BLUE               GPIO_PIN_2   ///< Map the \a green LED to hardware pin 2
#define LED_GREEN              GPIO_PIN_3   ///< Map the \a blue LED to hardware pin 3

/*! \def MAX_COUNT
   Counter workload
   Max counter to achieve 1 second
*/
#define MAX_COUNT               1333333
/*! \var counter 
         Dummy counter representing the thread workload
*/
volatile uint32_t counter ;

/*! 
    \brief Initializing the LEDs : RED, BLUE, GREN
*/
void LED_initialize(void)
{
	SYSCTL->RCGCGPIO |= (1UL << 5);  /* Enable clock for GPIOs    */

	//
	// Enable the GPIO pin for the LED (PF3).  Set the direction as output, and
	// enable the GPIO pin for digital function.
	//
	GPIOF->DIR = GPIOF->DIR | LED_GREEN | LED_RED | LED_BLUE;
	GPIOF->DEN = GPIOF->DEN | LED_GREEN | LED_RED | LED_BLUE;

  return;	
}

// -------------------------------------------------------------------------
/*!
    \brief Toggle a colour of the RGB LED
    \param id The LED to toggle (LED0, LED1, LED2)
	/// \note the GPIO DATA reg used to drive LEDs may be shared among threads & ISRs
  /// \note this "protected" version ensures that the data reg cannot be corrupted by sharing
  /// \note the "protected" version will always enable interrupts before returning 
*/
void protected_LED_blink( uint32_t id )
{
	uint32_t led;
	
	/// mapping from id to perpheral specifics in order to keep peripheral definitions only visible to peripherals
	switch (id) {
		case ( LED0 ):
			led = LED_RED;
			break;
		case ( LED1 ):
			led = LED_GREEN;
			break;
		case ( LED2 ):
			led = LED_BLUE;
			break;
	}

  // Toggle the LED ... GPIOF->DATA is shared by any thread (or kernel) using LEDs ... must protect
	__disable_irq();
  GPIOF->DATA ^= led;  // use bitwise XOR to toggle requested LED on or off
	__enable_irq();
  
}
 
/*!
    \brief Toggle a colour of the RGB LED
    \param id The LED to toggle (LED0, LED1, LED2)
	/// \note the GPIO DATA reg used to drive LEDs may be shared among threads & ISRs
  /// \note this "unprotected" version does not ensure that the data reg cannot be corrupted by sharing
  /// \note the "unprotected" version leaves the interrupts enabled/disabled throughout 
*/
void unprotected_LED_blink( uint32_t id )
{
	uint32_t led;
	
	/// mapping from id to perpheral specifics in order to keep peripheral definitions only visible to peripherals
	switch (id) {
		case ( LED0 ):
			led = LED_RED;
			break;
		case ( LED1 ):
			led = LED_GREEN;
			break;
		case ( LED2 ):
			led = LED_BLUE;
			break;
	}

  // Toggle the LED ... GPIOF->DATA is shared by any thread (or kernel) using LEDs ... must protect
  GPIOF->DATA ^= led;
} 
/*! 
    \brief Keep the processor busy for 1s by incrementing a counter.
*/
void count1Sec(void)
{
  uint32_t i;
    
  for (i=0; i< (uint32_t) MAX_COUNT; i++)
  {
    counter++;
  }
}

// -------------------------------------------------------------------------
/*!
    \brief Initializing UART for printing to serial console
    \details Use the CMSIS Driver implementation of the USART to initialize UART0. Configures the UART for 115,200, 8-N-1 operation.
*/
void UART_initialize(void)
{
	ARM_USART_SignalEvent_t cb_event;

	Driver_USART0.Initialize(cb_event);  		
  Driver_USART0.PowerControl(ARM_POWER_FULL);
	//
	// Configure the UART for 115,200, 8-N-1 operation.
	//	
	Driver_USART0.Control(ARM_USART_MODE_ASYNCHRONOUS,115200);
	Driver_USART0.Control(ARM_USART_CONTROL_TX,1);
	
  return;	
}

