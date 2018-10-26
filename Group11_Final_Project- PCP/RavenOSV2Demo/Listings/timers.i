#line 1 "timers.c"










#line 1 "D:\\Keil_v5\\ARM\\ARMCC\\Bin\\..\\include\\stdint.h"
 
 





 









     
#line 27 "D:\\Keil_v5\\ARM\\ARMCC\\Bin\\..\\include\\stdint.h"
     











#line 46 "D:\\Keil_v5\\ARM\\ARMCC\\Bin\\..\\include\\stdint.h"





 

     

     
typedef   signed          char int8_t;
typedef   signed short     int int16_t;
typedef   signed           int int32_t;
typedef   signed       __int64 int64_t;

     
typedef unsigned          char uint8_t;
typedef unsigned short     int uint16_t;
typedef unsigned           int uint32_t;
typedef unsigned       __int64 uint64_t;

     

     
     
typedef   signed          char int_least8_t;
typedef   signed short     int int_least16_t;
typedef   signed           int int_least32_t;
typedef   signed       __int64 int_least64_t;

     
typedef unsigned          char uint_least8_t;
typedef unsigned short     int uint_least16_t;
typedef unsigned           int uint_least32_t;
typedef unsigned       __int64 uint_least64_t;

     

     
typedef   signed           int int_fast8_t;
typedef   signed           int int_fast16_t;
typedef   signed           int int_fast32_t;
typedef   signed       __int64 int_fast64_t;

     
typedef unsigned           int uint_fast8_t;
typedef unsigned           int uint_fast16_t;
typedef unsigned           int uint_fast32_t;
typedef unsigned       __int64 uint_fast64_t;

     




typedef   signed           int intptr_t;
typedef unsigned           int uintptr_t;


     
typedef   signed     long long intmax_t;
typedef unsigned     long long uintmax_t;




     

     





     





     





     

     





     





     





     

     





     





     





     

     






     






     






     

     


     


     


     

     
#line 216 "D:\\Keil_v5\\ARM\\ARMCC\\Bin\\..\\include\\stdint.h"

     



     






     
    
 



#line 241 "D:\\Keil_v5\\ARM\\ARMCC\\Bin\\..\\include\\stdint.h"

     







     










     











#line 305 "D:\\Keil_v5\\ARM\\ARMCC\\Bin\\..\\include\\stdint.h"






 
#line 12 "timers.c"
#line 1 "D:\\Keil_v5\\ARM\\ARMCC\\Bin\\..\\include\\stdbool.h"
 






 





#line 25 "D:\\Keil_v5\\ARM\\ARMCC\\Bin\\..\\include\\stdbool.h"



#line 13 "timers.c"
#line 1 "inc/hw_types.h"















































#line 63 "inc/hw_types.h"




















































































#line 14 "timers.c"
#line 1 "driverlib/rom.h"


















































#line 76 "driverlib/rom.h"






#line 117 "driverlib/rom.h"






#line 458 "driverlib/rom.h"






#line 634 "driverlib/rom.h"






#line 829 "driverlib/rom.h"






#line 914 "driverlib/rom.h"






#line 957 "driverlib/rom.h"






#line 1076 "driverlib/rom.h"






#line 1250 "driverlib/rom.h"






#line 1495 "driverlib/rom.h"






#line 1966 "driverlib/rom.h"






#line 2097 "driverlib/rom.h"






#line 2193 "driverlib/rom.h"






#line 2555 "driverlib/rom.h"






#line 2940 "driverlib/rom.h"






#line 3354 "driverlib/rom.h"






#line 3493 "driverlib/rom.h"






#line 3707 "driverlib/rom.h"






#line 3787 "driverlib/rom.h"






#line 3877 "driverlib/rom.h"






#line 4244 "driverlib/rom.h"






#line 4409 "driverlib/rom.h"






#line 4536 "driverlib/rom.h"






#line 5192 "driverlib/rom.h"






#line 5381 "driverlib/rom.h"






#line 5606 "driverlib/rom.h"






#line 5990 "driverlib/rom.h"






#line 6036 "driverlib/rom.h"






#line 6112 "driverlib/rom.h"






#line 6459 "driverlib/rom.h"






#line 6913 "driverlib/rom.h"






#line 7169 "driverlib/rom.h"






#line 8105 "driverlib/rom.h"






#line 8274 "driverlib/rom.h"






#line 8345 "driverlib/rom.h"

#line 15 "timers.c"
#line 1 "driverlib/sysctl.h"






























































#line 140 "driverlib/sysctl.h"








#line 155 "driverlib/sysctl.h"








#line 171 "driverlib/sysctl.h"







#line 185 "driverlib/sysctl.h"
                                            





















#line 214 "driverlib/sysctl.h"







#line 385 "driverlib/sysctl.h"







#line 462 "driverlib/sysctl.h"

















#line 486 "driverlib/sysctl.h"








                                            

                                            











#line 516 "driverlib/sysctl.h"






#line 535 "driverlib/sysctl.h"















#line 556 "driverlib/sysctl.h"


























extern uint32_t SysCtlSRAMSizeGet(void);
extern uint32_t SysCtlFlashSizeGet(void);
extern uint32_t SysCtlFlashSectorSizeGet(void);
extern _Bool SysCtlPeripheralPresent(uint32_t ui32Peripheral);
extern _Bool SysCtlPeripheralReady(uint32_t ui32Peripheral);
extern void SysCtlPeripheralPowerOn(uint32_t ui32Peripheral);
extern void SysCtlPeripheralPowerOff(uint32_t ui32Peripheral);
extern void SysCtlPeripheralReset(uint32_t ui32Peripheral);
extern void SysCtlPeripheralEnable(uint32_t ui32Peripheral);
extern void SysCtlPeripheralDisable(uint32_t ui32Peripheral);
extern void SysCtlPeripheralSleepEnable(uint32_t ui32Peripheral);
extern void SysCtlPeripheralSleepDisable(uint32_t ui32Peripheral);
extern void SysCtlPeripheralDeepSleepEnable(uint32_t ui32Peripheral);
extern void SysCtlPeripheralDeepSleepDisable(uint32_t ui32Peripheral);
extern void SysCtlPeripheralClockGating(_Bool bEnable);
extern void SysCtlIntRegister(void (*pfnHandler)(void));
extern void SysCtlIntUnregister(void);
extern void SysCtlIntEnable(uint32_t ui32Ints);
extern void SysCtlIntDisable(uint32_t ui32Ints);
extern void SysCtlIntClear(uint32_t ui32Ints);
extern uint32_t SysCtlIntStatus(_Bool bMasked);
extern void SysCtlLDOSleepSet(uint32_t ui32Voltage);
extern uint32_t SysCtlLDOSleepGet(void);
extern void SysCtlLDODeepSleepSet(uint32_t ui32Voltage);
extern uint32_t SysCtlLDODeepSleepGet(void);
extern void SysCtlSleepPowerSet(uint32_t ui32Config);
extern void SysCtlDeepSleepPowerSet(uint32_t ui32Config);
extern void SysCtlReset(void);
extern void SysCtlSleep(void);
extern void SysCtlDeepSleep(void);
extern uint32_t SysCtlResetCauseGet(void);
extern void SysCtlResetCauseClear(uint32_t ui32Causes);
extern void SysCtlBrownOutConfigSet(uint32_t ui32Config,
                                    uint32_t ui32Delay);
extern void SysCtlDelay(uint32_t ui32Count);
extern void SysCtlMOSCConfigSet(uint32_t ui32Config);
extern uint32_t SysCtlPIOSCCalibrate(uint32_t ui32Type);
extern void SysCtlClockSet(uint32_t ui32Config);
extern uint32_t SysCtlClockGet(void);
extern void SysCtlDeepSleepClockSet(uint32_t ui32Config);
extern void SysCtlDeepSleepClockConfigSet(uint32_t ui32Div,
                                          uint32_t ui32Config);
extern void SysCtlPWMClockSet(uint32_t ui32Config);
extern uint32_t SysCtlPWMClockGet(void);
extern void SysCtlIOSCVerificationSet(_Bool bEnable);
extern void SysCtlMOSCVerificationSet(_Bool bEnable);
extern void SysCtlPLLVerificationSet(_Bool bEnable);
extern void SysCtlClkVerificationClear(void);
extern void SysCtlGPIOAHBEnable(uint32_t ui32GPIOPeripheral);
extern void SysCtlGPIOAHBDisable(uint32_t ui32GPIOPeripheral);
extern void SysCtlUSBPLLEnable(void);
extern void SysCtlUSBPLLDisable(void);
extern uint32_t SysCtlClockFreqSet(uint32_t ui32Config,
                                   uint32_t ui32SysClock);
extern void SysCtlResetBehaviorSet(uint32_t ui32Behavior);
extern uint32_t SysCtlResetBehaviorGet(void);
extern void SysCtlClockOutConfig(uint32_t ui32Config, uint32_t ui32Div);
extern void SysCtlAltClkConfig(uint32_t ui32Config);
extern uint32_t SysCtlNMIStatus(void);
extern void SysCtlNMIClear(uint32_t ui32Status);
extern void SysCtlVoltageEventConfig(uint32_t ui32Config);
extern uint32_t SysCtlVoltageEventStatus(void);
extern void SysCtlVoltageEventClear(uint32_t ui32Status);
extern _Bool SysCtlVCOGet(uint32_t ui32Crystal, uint32_t *pui32VCOFrequency);










#line 16 "timers.c"
#line 1 "driverlib/timer.h"




























































                                            


                                            
#line 86 "driverlib/timer.h"
                                             



                                             

                                             

                                             

                                             

                                             

                                             

                                             



                                             

                                             

                                             

                                             

                                             

                                             








#line 136 "driverlib/timer.h"

























#line 185 "driverlib/timer.h"
















#line 210 "driverlib/timer.h"







#line 226 "driverlib/timer.h"

















extern void TimerEnable(uint32_t ui32Base, uint32_t ui32Timer);
extern void TimerDisable(uint32_t ui32Base, uint32_t ui32Timer);
extern void TimerConfigure(uint32_t ui32Base, uint32_t ui32Config);
extern void TimerControlLevel(uint32_t ui32Base, uint32_t ui32Timer,
                              _Bool bInvert);
extern void TimerControlTrigger(uint32_t ui32Base, uint32_t ui32Timer,
                                _Bool bEnable);
extern void TimerControlEvent(uint32_t ui32Base, uint32_t ui32Timer,
                              uint32_t ui32Event);
extern void TimerControlStall(uint32_t ui32Base, uint32_t ui32Timer,
                              _Bool bStall);
extern void TimerControlWaitOnTrigger(uint32_t ui32Base, uint32_t ui32Timer,
                                      _Bool bWait);
extern void TimerRTCEnable(uint32_t ui32Base);
extern void TimerRTCDisable(uint32_t ui32Base);
extern void TimerPrescaleSet(uint32_t ui32Base, uint32_t ui32Timer,
                             uint32_t ui32Value);
extern uint32_t TimerPrescaleGet(uint32_t ui32Base, uint32_t ui32Timer);
extern void TimerPrescaleMatchSet(uint32_t ui32Base, uint32_t ui32Timer,
                                  uint32_t ui32Value);
extern uint32_t TimerPrescaleMatchGet(uint32_t ui32Base, uint32_t ui32Timer);
extern void TimerLoadSet(uint32_t ui32Base, uint32_t ui32Timer,
                         uint32_t ui32Value);
extern uint32_t TimerLoadGet(uint32_t ui32Base, uint32_t ui32Timer);
extern void TimerLoadSet64(uint32_t ui32Base, uint64_t ui64Value);
extern uint64_t TimerLoadGet64(uint32_t ui32Base);
extern uint32_t TimerValueGet(uint32_t ui32Base, uint32_t ui32Timer);
extern uint64_t TimerValueGet64(uint32_t ui32Base);
extern void TimerMatchSet(uint32_t ui32Base, uint32_t ui32Timer,
                          uint32_t ui32Value);
extern uint32_t TimerMatchGet(uint32_t ui32Base, uint32_t ui32Timer);
extern void TimerMatchSet64(uint32_t ui32Base, uint64_t ui64Value);
extern uint64_t TimerMatchGet64(uint32_t ui32Base);
extern void TimerIntRegister(uint32_t ui32Base, uint32_t ui32Timer,
                             void (*pfnHandler)(void));
extern void TimerIntUnregister(uint32_t ui32Base, uint32_t ui32Timer);
extern void TimerIntEnable(uint32_t ui32Base, uint32_t ui32IntFlags);
extern void TimerIntDisable(uint32_t ui32Base, uint32_t ui32IntFlags);
extern uint32_t TimerIntStatus(uint32_t ui32Base, _Bool bMasked);
extern void TimerIntClear(uint32_t ui32Base, uint32_t ui32IntFlags);
extern void TimerSynchronize(uint32_t ui32Base, uint32_t ui32Timers);
extern uint32_t TimerClockSourceGet(uint32_t ui32Base);
extern void TimerClockSourceSet(uint32_t ui32Base, uint32_t ui32Source);
extern uint32_t TimerADCEventGet(uint32_t ui32Base);
extern void TimerADCEventSet(uint32_t ui32Base, uint32_t ui32ADCEvent);
extern uint32_t TimerDMAEventGet(uint32_t ui32Base);
extern void TimerDMAEventSet(uint32_t ui32Base, uint32_t ui32DMAEvent);
extern void TimerUpdateMode(uint32_t ui32Base, uint32_t ui32Timer,
                            uint32_t ui32Config);









#line 17 "timers.c"
#line 1 "timers.h"



 




#line 10 "timers.h"







#line 23 "timers.h"


 

void Timer0_Init (void);  
 
void Timer1_Init (void);  

void Timer_Enable(uint32_t base, uint32_t timer); 

void Timer_Disable(uint32_t base, uint32_t timer); 

uint32_t Timer_Get_Value(uint32_t base, uint32_t timer); 



#line 18 "timers.c"


uint32_t Problem1_tick = 0;
uint32_t Problem2_tick = 0;
uint32_t Problem3_tick = 0;
uint32_t Problem4_tick = 0;
uint32_t Problem5_tick = 0;



















void Timer1_Init(void)
{    
    
    
    
    
    
    
    
    
    
    
    

    ((void (*)(uint32_t ui32Config))((uint32_t *)(((uint32_t *)0x01000010)[13]))[23])(0x07800000 | 0x00003800 | 0x00000000 |
                     0x00000540);

    

    ((void (*)(uint32_t ui32Peripheral))((uint32_t *)(((uint32_t *)0x01000010)[13]))[6])(0xf0000401);

    

    ((void (*)(uint32_t ui32Peripheral))((uint32_t *)(((uint32_t *)0x01000010)[13]))[5])(0xf0000401);

    

    ((void (*)(uint32_t ui32Base, uint32_t ui32Config))((uint32_t *)(((uint32_t *)0x01000010)[11]))[3])(0x40031000, 0x00000031);

    

    ((void (*)(uint32_t ui32Base, uint32_t ui32Timer, uint32_t ui32Value))((uint32_t *)(((uint32_t *)0x01000010)[11]))[14])(0x40031000, 0x000000ff, 0xFFFFFFFF);

}











void Timer_Enable(uint32_t base, uint32_t timer) 
{
	
    ((void (*)(uint32_t ui32Base, uint32_t ui32Timer))((uint32_t *)(((uint32_t *)0x01000010)[11]))[2])(base, timer);
	
    
    
    
    
    
    
    
    
    
    
    
    
    (*((volatile uint32_t *)(base + 0x00000050))) = 0;

    
    ((void (*)(uint32_t ui32Base, uint32_t ui32Timer))((uint32_t *)(((uint32_t *)0x01000010)[11]))[1])(base, timer);
}











void Timer_Disable(uint32_t base, uint32_t timer) 
{
   
    ((void (*)(uint32_t ui32Base, uint32_t ui32Timer))((uint32_t *)(((uint32_t *)0x01000010)[11]))[2])(base, timer);
}












uint32_t Timer_Get_Value(uint32_t base, uint32_t timer)
{	 
	
    return(((uint32_t (*)(uint32_t ui32Base, uint32_t ui32Timer))((uint32_t *)(((uint32_t *)0x01000010)[11]))[16])(base,timer));
}
