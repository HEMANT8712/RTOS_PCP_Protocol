#line 1 "thread0.c"



 



#line 1 ".\\RTE\\RTOS\\Include\\peripherals.h"


 




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






 
#line 9 ".\\RTE\\RTOS\\Include\\peripherals.h"





 
void LED_initialize(void);      
void protected_LED_blink( uint32_t led ); 
void unprotected_LED_blink( uint32_t led ); 
void UART_initialize(void);     

void count1Sec(void);           

#line 9 "thread0.c"
#line 1 ".\\RTE\\Application\\include\\osObjects.h"



 




#line 1 ".\\RTE\\RTOS\\Include\\RavenOS.h"



 






















































 






















































































 


















#line 173 ".\\RTE\\RTOS\\Include\\RavenOS.h"

#line 175 ".\\RTE\\RTOS\\Include\\RavenOS.h"
#line 1 "D:\\Keil_v5\\ARM\\ARMCC\\Bin\\..\\include\\stddef.h"
 






 

 
 
 





 





#line 34 "D:\\Keil_v5\\ARM\\ARMCC\\Bin\\..\\include\\stddef.h"




  typedef signed int ptrdiff_t;



  



    typedef unsigned int size_t;    
#line 57 "D:\\Keil_v5\\ARM\\ARMCC\\Bin\\..\\include\\stddef.h"



   



      typedef unsigned short wchar_t;  
#line 82 "D:\\Keil_v5\\ARM\\ARMCC\\Bin\\..\\include\\stddef.h"



    




   




  typedef long double max_align_t;









#line 114 "D:\\Keil_v5\\ARM\\ARMCC\\Bin\\..\\include\\stddef.h"



 

#line 176 ".\\RTE\\RTOS\\Include\\RavenOS.h"













typedef enum  {
  osPriorityIdle          = -3,          
  osPriorityLow           = -2,          
  osPriorityBelowNormal   = -1,          
  osPriorityNormal        =  0,          
  osPriorityAboveNormal   = +1,          
  osPriorityHigh          = +2,          
  osPriorityRealtime      = +3,          
  osPriorityError         =  0x84,        
  os_priority_reserved      =  0x7FFFFFFF  
} osPriority;







typedef enum os_priority {  
  osOK                    =     0,       
  osEventSignal           =  0x08,       
  osEventMessage          =  0x10,       
  osEventMail             =  0x20,       
  osEventTimeout          =  0x40,       
  osErrorParameter        =  0x80,       
  osErrorResource         =  0x81,       
  osErrorTimeoutResource  =  0xC1,       
  osErrorISR              =  0x82,       
  osErrorISRRecursive     =  0x83,       
  osErrorPriority         =  0x84,       
  osErrorNoMemory         =  0x85,       
  osErrorValue            =  0x86,       
  osErrorOS               =  0xFF,       
  os_status_reserved      =  0x7FFFFFFF  
} osStatus;




typedef enum  {
  osTimerOnce             =     0,       
  osTimerPeriodic         =     1        
} os_timer_type;



typedef void (*os_pthread) (void const *argument);



typedef void (*os_ptimer) (void const *argument);











typedef struct os_thread_timed os_thread_timed; 




typedef struct os_thread_def *osThreadId;


typedef struct os_thread_def *os_tcb_p;



typedef struct os_timer_cb *osTimerId;



typedef struct os_mutex_cb *osMutexId;




typedef struct os_semaphore_def *osSemaphoreId;





typedef struct os_pool_cb *osPoolId;



typedef struct os_messageQ_cb *osMessageQId;



typedef struct os_mailQ_cb *osMailQId;



extern osThreadId thread_list_h; 
extern uint32_t th_q_cnt;

extern osThreadId rtr_q_h;     

extern uint32_t rtr_q_cnt;   



 


struct os_thread_timed
{  
	osThreadId threadId;   
	uint32_t   expiryTime; 
	uint32_t   ticks; 		 
};

typedef enum os_thread_status 
{
	TH_RUNNING,         
	

	TH_BLOCKED,         
	TH_ASLEEP,          
	TH_DEAD             
} osThreadStatus;



typedef struct os_thread_def  {
	
	
	uint8_t * stack_p;      
	os_pthread start_p;    
  osPriority  tpriority;    
	uint32_t stack_size;   
	
	osPriority priority;   
	os_tcb_p th_list_p;       
	os_tcb_p rtr_q_p;       
	osSemaphoreId semaphore_id; 
	os_tcb_p blocked_q_p;       
  uint32_t time_count;   
	uint32_t timed_q_p;    
	osStatus timed_ret;    
	



  
	osThreadStatus status; 

} osThreadDef_t;



typedef struct os_timer_def  {
  os_ptimer                 ptimer;    
} osTimerDef_t;



typedef struct os_mutex_def  {
  uint32_t                   dummy;    
} osMutexDef_t;



typedef struct os_semaphore_def  {
	
	os_tcb_p                   blocked_q_h;					   
	uint32_t                   blocked_q_cnt;                  
	int32_t                    ownCount;                       
	osSemaphoreId				       next;		                       
} osSemaphoreDef_t;



typedef struct os_pool_def  {
  uint32_t                 pool_sz;    
  uint32_t                 item_sz;    
  void                       *pool;    
} osPoolDef_t;



typedef struct os_messageQ_def  {
  uint32_t                queue_sz;    
  uint32_t                 item_sz;    
  void                       *pool;    
} osMessageQDef_t;



typedef struct os_mailQ_def  {
  uint32_t                queue_sz;    
  uint32_t                 item_sz;    
  void                       *pool;    
} osMailQDef_t;




typedef struct  {
  osStatus                 status;     
  union  {
    uint32_t                    v;     
    void                       *p;     
    int32_t               signals;     
  } value;                             
  union  {
    osMailQId             mail_id;     
    osMessageQId       message_id;     
  } def;                               
} osEvent;







osStatus osKernelInitialize (void);




osStatus osKernelStart (void);




int32_t osKernelRunning(void);






uint32_t osKernelSysTick (void);






















#line 463 ".\\RTE\\RTOS\\Include\\RavenOS.h"















osThreadId osThreadCreate ( osThreadDef_t *thread_def, void *argument);



void osInsertRTRQ( os_tcb_p th );
void osRemoveRTRQ( os_tcb_p th );




osThreadId osThreadGetId (void);





osStatus osThreadTerminate (osThreadId thread_id);




osStatus osThreadYield (void);






osStatus osThreadSetPriority (osThreadId thread_id, osPriority priority);





osPriority osThreadGetPriority (osThreadId thread_id);








osStatus osDelay (uint32_t millisec);

#line 532 ".\\RTE\\RTOS\\Include\\RavenOS.h"








#line 548 ".\\RTE\\RTOS\\Include\\RavenOS.h"














osTimerId osTimerCreate (const osTimerDef_t *timer_def, os_timer_type type, void *argument);






osStatus osTimerStart (osTimerId timer_id, uint32_t millisec);





osStatus osTimerStop (osTimerId timer_id);





osStatus osTimerDelete (osTimerId timer_id);









int32_t osSignalSet (osThreadId thread_id, int32_t signals);






int32_t osSignalClear (osThreadId thread_id, int32_t signals);






osEvent osSignalWait (int32_t signals, uint32_t millisec);








#line 621 ".\\RTE\\RTOS\\Include\\RavenOS.h"












osMutexId osMutexCreate (const osMutexDef_t *mutex_def);






osStatus osMutexWait (osMutexId mutex_id, uint32_t millisec);





osStatus osMutexRelease (osMutexId mutex_id);





osStatus osMutexDelete (osMutexId mutex_id);










#line 670 ".\\RTE\\RTOS\\Include\\RavenOS.h"




















osSemaphoreId osSemaphoreCreate (osSemaphoreDef_t *semaphore_def, int32_t count);






int32_t osSemaphoreWait (osSemaphoreId semaphore_id, uint32_t millisec);





osStatus osSemaphoreRelease (osSemaphoreId semaphore_id);






osStatus osSemaphoreDelete (osSemaphoreId semaphore_id);












#line 773 ".\\RTE\\RTOS\\Include\\RavenOS.h"




#line 824 ".\\RTE\\RTOS\\Include\\RavenOS.h"




#line 895 ".\\RTE\\RTOS\\Include\\RavenOS.h"






#line 10 ".\\RTE\\Application\\include\\osObjects.h"


 

 








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


extern osSemaphoreId sid_Semaphore0;
int Init_Semaphore0 (void);
int Delete_Semaphore0 (void);

extern osSemaphoreId sid_Semaphore1;
int Init_Semaphore1 (void);
int Delete_Semaphore1 (void);

extern osSemaphoreId sid_Semaphore2;
int Init_Semaphore2 (void);
int Delete_Semaphore2 (void);

extern osSemaphoreId sid_Semaphore3;
int Init_Semaphore3 (void);
int Delete_Semaphore3 (void);

extern osSemaphoreId sid_pce_Semaphore1;
int Init_pce_Semaphore1 (void);
int Delete_pce_Semaphore1 (void);

extern osSemaphoreId sid_pce_Semaphore2;
int Init_pce_Semaphore2 (void);
int Delete_pce_Semaphore2 (void);


#line 10 "thread0.c"
#line 1 ".\\RTE\\RTOS\\Include\\trace.h"



 




#line 10 ".\\RTE\\RTOS\\Include\\trace.h"




uint32_t addTraceProtected(char * message);
void dumpTraceProtected(void);

uint32_t addTrace(char * message);
void dumpTrace(void);
uint32_t getTraceCounter(void);

#line 11 "thread0.c"
#line 1 "D:\\Keil_v5\\ARM\\ARMCC\\Bin\\..\\include\\stdio.h"
 
 
 





 






 







 




  
 








#line 47 "D:\\Keil_v5\\ARM\\ARMCC\\Bin\\..\\include\\stdio.h"


  



    typedef unsigned int size_t;    









 
 

 



    typedef struct __va_list __va_list;






   




 




typedef struct __fpos_t_struct {
    unsigned __int64 __pos;
    



 
    struct {
        unsigned int __state1, __state2;
    } __mbstate;
} fpos_t;
   


 


   

 

typedef struct __FILE FILE;
   






 

#line 136 "D:\\Keil_v5\\ARM\\ARMCC\\Bin\\..\\include\\stdio.h"


extern FILE __stdin, __stdout, __stderr;
extern FILE *__aeabi_stdin, *__aeabi_stdout, *__aeabi_stderr;

#line 166 "D:\\Keil_v5\\ARM\\ARMCC\\Bin\\..\\include\\stdio.h"
    

    

    





     



   


 


   


 

   



 

   


 




   


 





    


 






extern __declspec(__nothrow) int remove(const char *  ) __attribute__((__nonnull__(1)));
   





 
extern __declspec(__nothrow) int rename(const char *  , const char *  ) __attribute__((__nonnull__(1,2)));
   








 
extern __declspec(__nothrow) FILE *tmpfile(void);
   




 
extern __declspec(__nothrow) char *tmpnam(char *  );
   











 

extern __declspec(__nothrow) int fclose(FILE *  ) __attribute__((__nonnull__(1)));
   







 
extern __declspec(__nothrow) int fflush(FILE *  );
   







 
extern __declspec(__nothrow) FILE *fopen(const char * __restrict  ,
                           const char * __restrict  ) __attribute__((__nonnull__(1,2)));
   








































 
extern __declspec(__nothrow) FILE *freopen(const char * __restrict  ,
                    const char * __restrict  ,
                    FILE * __restrict  ) __attribute__((__nonnull__(2,3)));
   








 
extern __declspec(__nothrow) void setbuf(FILE * __restrict  ,
                    char * __restrict  ) __attribute__((__nonnull__(1)));
   




 
extern __declspec(__nothrow) int setvbuf(FILE * __restrict  ,
                   char * __restrict  ,
                   int  , size_t  ) __attribute__((__nonnull__(1)));
   















 
#pragma __printf_args
extern __declspec(__nothrow) int fprintf(FILE * __restrict  ,
                    const char * __restrict  , ...) __attribute__((__nonnull__(1,2)));
   


















 
#pragma __printf_args
extern __declspec(__nothrow) int _fprintf(FILE * __restrict  ,
                     const char * __restrict  , ...) __attribute__((__nonnull__(1,2)));
   



 
#pragma __printf_args
extern __declspec(__nothrow) int printf(const char * __restrict  , ...) __attribute__((__nonnull__(1)));
   




 
#pragma __printf_args
extern __declspec(__nothrow) int _printf(const char * __restrict  , ...) __attribute__((__nonnull__(1)));
   



 
#pragma __printf_args
extern __declspec(__nothrow) int sprintf(char * __restrict  , const char * __restrict  , ...) __attribute__((__nonnull__(1,2)));
   






 
#pragma __printf_args
extern __declspec(__nothrow) int _sprintf(char * __restrict  , const char * __restrict  , ...) __attribute__((__nonnull__(1,2)));
   



 

#pragma __printf_args
extern __declspec(__nothrow) int __ARM_snprintf(char * __restrict  , size_t  ,
                     const char * __restrict  , ...) __attribute__((__nonnull__(3)));


#pragma __printf_args
extern __declspec(__nothrow) int snprintf(char * __restrict  , size_t  ,
                     const char * __restrict  , ...) __attribute__((__nonnull__(3)));
   















 

#pragma __printf_args
extern __declspec(__nothrow) int _snprintf(char * __restrict  , size_t  ,
                      const char * __restrict  , ...) __attribute__((__nonnull__(3)));
   



 
#pragma __scanf_args
extern __declspec(__nothrow) int fscanf(FILE * __restrict  ,
                    const char * __restrict  , ...) __attribute__((__nonnull__(1,2)));
   






























 
#pragma __scanf_args
extern __declspec(__nothrow) int _fscanf(FILE * __restrict  ,
                     const char * __restrict  , ...) __attribute__((__nonnull__(1,2)));
   



 
#pragma __scanf_args
extern __declspec(__nothrow) int scanf(const char * __restrict  , ...) __attribute__((__nonnull__(1)));
   






 
#pragma __scanf_args
extern __declspec(__nothrow) int _scanf(const char * __restrict  , ...) __attribute__((__nonnull__(1)));
   



 
#pragma __scanf_args
extern __declspec(__nothrow) int sscanf(const char * __restrict  ,
                    const char * __restrict  , ...) __attribute__((__nonnull__(1,2)));
   








 
#pragma __scanf_args
extern __declspec(__nothrow) int _sscanf(const char * __restrict  ,
                     const char * __restrict  , ...) __attribute__((__nonnull__(1,2)));
   



 

 
extern __declspec(__nothrow) int vfscanf(FILE * __restrict  , const char * __restrict  , __va_list) __attribute__((__nonnull__(1,2)));
extern __declspec(__nothrow) int vscanf(const char * __restrict  , __va_list) __attribute__((__nonnull__(1)));
extern __declspec(__nothrow) int vsscanf(const char * __restrict  , const char * __restrict  , __va_list) __attribute__((__nonnull__(1,2)));

extern __declspec(__nothrow) int _vfscanf(FILE * __restrict  , const char * __restrict  , __va_list) __attribute__((__nonnull__(1,2)));
extern __declspec(__nothrow) int _vscanf(const char * __restrict  , __va_list) __attribute__((__nonnull__(1)));
extern __declspec(__nothrow) int _vsscanf(const char * __restrict  , const char * __restrict  , __va_list) __attribute__((__nonnull__(1,2)));
extern __declspec(__nothrow) int __ARM_vsscanf(const char * __restrict  , const char * __restrict  , __va_list) __attribute__((__nonnull__(1,2)));

extern __declspec(__nothrow) int vprintf(const char * __restrict  , __va_list  ) __attribute__((__nonnull__(1)));
   





 
extern __declspec(__nothrow) int _vprintf(const char * __restrict  , __va_list  ) __attribute__((__nonnull__(1)));
   



 
extern __declspec(__nothrow) int vfprintf(FILE * __restrict  ,
                    const char * __restrict  , __va_list  ) __attribute__((__nonnull__(1,2)));
   






 
extern __declspec(__nothrow) int vsprintf(char * __restrict  ,
                     const char * __restrict  , __va_list  ) __attribute__((__nonnull__(1,2)));
   






 
extern __declspec(__nothrow) int __ARM_vsnprintf(char * __restrict  , size_t  ,
                     const char * __restrict  , __va_list  ) __attribute__((__nonnull__(3)));

extern __declspec(__nothrow) int vsnprintf(char * __restrict  , size_t  ,
                     const char * __restrict  , __va_list  ) __attribute__((__nonnull__(3)));
   







 

extern __declspec(__nothrow) int _vsprintf(char * __restrict  ,
                      const char * __restrict  , __va_list  ) __attribute__((__nonnull__(1,2)));
   



 
extern __declspec(__nothrow) int _vfprintf(FILE * __restrict  ,
                     const char * __restrict  , __va_list  ) __attribute__((__nonnull__(1,2)));
   



 
extern __declspec(__nothrow) int _vsnprintf(char * __restrict  , size_t  ,
                      const char * __restrict  , __va_list  ) __attribute__((__nonnull__(3)));
   



 

#pragma __printf_args
extern __declspec(__nothrow) int asprintf(char **  , const char * __restrict  , ...) __attribute__((__nonnull__(2)));
extern __declspec(__nothrow) int vasprintf(char **  , const char * __restrict  , __va_list  ) __attribute__((__nonnull__(2)));

#pragma __printf_args
extern __declspec(__nothrow) int __ARM_asprintf(char **  , const char * __restrict  , ...) __attribute__((__nonnull__(2)));
extern __declspec(__nothrow) int __ARM_vasprintf(char **  , const char * __restrict  , __va_list  ) __attribute__((__nonnull__(2)));
   








 

extern __declspec(__nothrow) int fgetc(FILE *  ) __attribute__((__nonnull__(1)));
   







 
extern __declspec(__nothrow) char *fgets(char * __restrict  , int  ,
                    FILE * __restrict  ) __attribute__((__nonnull__(1,3)));
   










 
extern __declspec(__nothrow) int fputc(int  , FILE *  ) __attribute__((__nonnull__(2)));
   







 
extern __declspec(__nothrow) int fputs(const char * __restrict  , FILE * __restrict  ) __attribute__((__nonnull__(1,2)));
   




 
extern __declspec(__nothrow) int getc(FILE *  ) __attribute__((__nonnull__(1)));
   







 




    extern __declspec(__nothrow) int (getchar)(void);

   





 
extern __declspec(__nothrow) char *gets(char *  ) __attribute__((__nonnull__(1)));
   









 
extern __declspec(__nothrow) int putc(int  , FILE *  ) __attribute__((__nonnull__(2)));
   





 




    extern __declspec(__nothrow) int (putchar)(int  );

   



 
extern __declspec(__nothrow) int puts(const char *  ) __attribute__((__nonnull__(1)));
   





 
extern __declspec(__nothrow) int ungetc(int  , FILE *  ) __attribute__((__nonnull__(2)));
   






















 

extern __declspec(__nothrow) size_t fread(void * __restrict  ,
                    size_t  , size_t  , FILE * __restrict  ) __attribute__((__nonnull__(1,4)));
   











 

extern __declspec(__nothrow) size_t __fread_bytes_avail(void * __restrict  ,
                    size_t  , FILE * __restrict  ) __attribute__((__nonnull__(1,3)));
   











 

extern __declspec(__nothrow) size_t fwrite(const void * __restrict  ,
                    size_t  , size_t  , FILE * __restrict  ) __attribute__((__nonnull__(1,4)));
   







 

extern __declspec(__nothrow) int fgetpos(FILE * __restrict  , fpos_t * __restrict  ) __attribute__((__nonnull__(1,2)));
   








 
extern __declspec(__nothrow) int fseek(FILE *  , long int  , int  ) __attribute__((__nonnull__(1)));
   














 
extern __declspec(__nothrow) int fsetpos(FILE * __restrict  , const fpos_t * __restrict  ) __attribute__((__nonnull__(1,2)));
   










 
extern __declspec(__nothrow) long int ftell(FILE *  ) __attribute__((__nonnull__(1)));
   











 
extern __declspec(__nothrow) void rewind(FILE *  ) __attribute__((__nonnull__(1)));
   





 

extern __declspec(__nothrow) void clearerr(FILE *  ) __attribute__((__nonnull__(1)));
   




 

extern __declspec(__nothrow) int feof(FILE *  ) __attribute__((__nonnull__(1)));
   


 
extern __declspec(__nothrow) int ferror(FILE *  ) __attribute__((__nonnull__(1)));
   


 
extern __declspec(__nothrow) void perror(const char *  );
   









 

extern __declspec(__nothrow) int _fisatty(FILE *   ) __attribute__((__nonnull__(1)));
    
 

extern __declspec(__nothrow) void __use_no_semihosting_swi(void);
extern __declspec(__nothrow) void __use_no_semihosting(void);
    





 











#line 1021 "D:\\Keil_v5\\ARM\\ARMCC\\Bin\\..\\include\\stdio.h"



 

#line 12 "thread0.c"

#line 1 ".\\RTE\\_RavenOS_Demo\\RTE_Components.h"







 







 


#line 20 ".\\RTE\\_RavenOS_Demo\\RTE_Components.h"
#line 1 "D:\\Keil_v5\\ARM\\ARMCC\\Bin\\..\\include\\stdbool.h"
 






 





#line 25 "D:\\Keil_v5\\ARM\\ARMCC\\Bin\\..\\include\\stdbool.h"



#line 21 ".\\RTE\\_RavenOS_Demo\\RTE_Components.h"
#line 1 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\inc/hw_ints.h"
















































#line 58 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\inc/hw_ints.h"






#line 94 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\inc/hw_ints.h"
                                            
#line 170 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\inc/hw_ints.h"






#line 244 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\inc/hw_ints.h"
                                            
#line 283 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\inc/hw_ints.h"






#line 318 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\inc/hw_ints.h"






#line 339 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\inc/hw_ints.h"













#line 475 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\inc/hw_ints.h"
















#line 22 ".\\RTE\\_RavenOS_Demo\\RTE_Components.h"
#line 1 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\inc/hw_gpio.h"















































#line 79 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\inc/hw_gpio.h"







                                            









                                            









                                            



















                                            

                                            
















                                            
                                            
                                            
                                            
                                            



































#line 194 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\inc/hw_gpio.h"
                                            
                                            
                                            

                                            

                                            
                                            
                                            
                                            
                                            
#line 212 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\inc/hw_gpio.h"

#line 23 ".\\RTE\\_RavenOS_Demo\\RTE_Components.h"
#line 1 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\inc/hw_types.h"















































#line 63 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\inc/hw_types.h"




















































































#line 24 ".\\RTE\\_RavenOS_Demo\\RTE_Components.h"
#line 1 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/debug.h"
















































extern void __error__(char *pcFilename, uint32_t ui32Line);







#line 69 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/debug.h"

#line 25 ".\\RTE\\_RavenOS_Demo\\RTE_Components.h"
#line 1 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/fpu.h"





























































































extern void FPUEnable(void);
extern void FPUDisable(void);
extern void FPUStackingEnable(void);
extern void FPULazyStackingEnable(void);
extern void FPUStackingDisable(void);
extern void FPUHalfPrecisionModeSet(uint32_t ui32Mode);
extern void FPUNaNModeSet(uint32_t ui32Mode);
extern void FPUFlushToZeroModeSet(uint32_t ui32Mode);
extern void FPURoundingModeSet(uint32_t ui32Mode);










#line 26 ".\\RTE\\_RavenOS_Demo\\RTE_Components.h"
#line 1 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/gpio.h"



























































#line 68 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/gpio.h"

















#line 91 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/gpio.h"







#line 105 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/gpio.h"







#line 119 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/gpio.h"







#line 135 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/gpio.h"






extern void GPIODirModeSet(uint32_t ui32Port, uint8_t ui8Pins,
                           uint32_t ui32PinIO);
extern uint32_t GPIODirModeGet(uint32_t ui32Port, uint8_t ui8Pin);
extern void GPIOIntTypeSet(uint32_t ui32Port, uint8_t ui8Pins,
                           uint32_t ui32IntType);
extern uint32_t GPIOIntTypeGet(uint32_t ui32Port, uint8_t ui8Pin);
extern void GPIOPadConfigSet(uint32_t ui32Port, uint8_t ui8Pins,
                             uint32_t ui32Strength, uint32_t ui32PadType);
extern void GPIOPadConfigGet(uint32_t ui32Port, uint8_t ui8Pin,
                             uint32_t *pui32Strength, uint32_t *pui32PadType);
extern void GPIOIntEnable(uint32_t ui32Port, uint32_t ui32IntFlags);
extern void GPIOIntDisable(uint32_t ui32Port, uint32_t ui32IntFlags);
extern uint32_t GPIOIntStatus(uint32_t ui32Port, _Bool bMasked);
extern void GPIOIntClear(uint32_t ui32Port, uint32_t ui32IntFlags);
extern void GPIOIntRegister(uint32_t ui32Port, void (*pfnIntHandler)(void));
extern void GPIOIntUnregister(uint32_t ui32Port);
extern int32_t GPIOPinRead(uint32_t ui32Port, uint8_t ui8Pins);
extern void GPIOPinWrite(uint32_t ui32Port, uint8_t ui8Pins, uint8_t ui8Val);
extern void GPIOPinConfigure(uint32_t ui32PinConfig);
extern void GPIOPinTypeADC(uint32_t ui32Port, uint8_t ui8Pins);
extern void GPIOPinTypeCAN(uint32_t ui32Port, uint8_t ui8Pins);
extern void GPIOPinTypeComparator(uint32_t ui32Port, uint8_t ui8Pins);
extern void GPIOPinTypeEPI(uint32_t ui32Port, uint8_t ui8Pins);
extern void GPIOPinTypeEthernetLED(uint32_t ui32Port, uint8_t ui8Pins);
extern void GPIOPinTypeEthernetMII(uint32_t ui32Port, uint8_t ui8Pins);
extern void GPIOPinTypeGPIOInput(uint32_t ui32Port, uint8_t ui8Pins);
extern void GPIOPinTypeGPIOOutput(uint32_t ui32Port, uint8_t ui8Pins);
extern void GPIOPinTypeGPIOOutputOD(uint32_t ui32Port, uint8_t ui8Pins);
extern void GPIOPinTypeI2C(uint32_t ui32Port, uint8_t ui8Pins);
extern void GPIOPinTypeI2CSCL(uint32_t ui32Port, uint8_t ui8Pins);
extern void GPIOPinTypeLCD(uint32_t ui32Port, uint8_t ui8Pins);
extern void GPIOPinTypePWM(uint32_t ui32Port, uint8_t ui8Pins);
extern void GPIOPinTypeQEI(uint32_t ui32Port, uint8_t ui8Pins);
extern void GPIOPinTypeSSI(uint32_t ui32Port, uint8_t ui8Pins);
extern void GPIOPinTypeTimer(uint32_t ui32Port, uint8_t ui8Pins);
extern void GPIOPinTypeUART(uint32_t ui32Port, uint8_t ui8Pins);
extern void GPIOPinTypeUSBAnalog(uint32_t ui32Port, uint8_t ui8Pins);
extern void GPIOPinTypeUSBDigital(uint32_t ui32Port, uint8_t ui8Pins);
extern void GPIOPinTypeWakeHigh(uint32_t ui32Port, uint8_t ui8Pins);
extern void GPIOPinTypeWakeLow(uint32_t ui32Port, uint8_t ui8Pins);
extern uint32_t GPIOPinWakeStatus(uint32_t ui32Port);
extern void GPIODMATriggerEnable(uint32_t ui32Port, uint8_t ui8Pins);
extern void GPIODMATriggerDisable(uint32_t ui32Port, uint8_t ui8Pins);
extern void GPIOADCTriggerEnable(uint32_t ui32Port, uint8_t ui8Pins);
extern void GPIOADCTriggerDisable(uint32_t ui32Port, uint8_t ui8Pins);










#line 27 ".\\RTE\\_RavenOS_Demo\\RTE_Components.h"
#line 1 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/interrupt.h"


































































extern _Bool IntMasterEnable(void);
extern _Bool IntMasterDisable(void);
extern void IntRegister(uint32_t ui32Interrupt, void (*pfnHandler)(void));
extern void IntUnregister(uint32_t ui32Interrupt);
extern void IntPriorityGroupingSet(uint32_t ui32Bits);
extern uint32_t IntPriorityGroupingGet(void);
extern void IntPrioritySet(uint32_t ui32Interrupt,
                           uint8_t ui8Priority);
extern int32_t IntPriorityGet(uint32_t ui32Interrupt);
extern void IntEnable(uint32_t ui32Interrupt);
extern void IntDisable(uint32_t ui32Interrupt);
extern uint32_t IntIsEnabled(uint32_t ui32Interrupt);
extern void IntPendSet(uint32_t ui32Interrupt);
extern void IntPendClear(uint32_t ui32Interrupt);
extern void IntPriorityMaskSet(uint32_t ui32PriorityMask);
extern uint32_t IntPriorityMaskGet(void);
extern void IntTrigger(uint32_t ui32Interrupt);










#line 28 ".\\RTE\\_RavenOS_Demo\\RTE_Components.h"
#line 1 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"















































#line 213 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 384 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 555 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 726 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 875 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 1024 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 1250 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 1399 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 1625 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 1774 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 2000 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 2171 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 2342 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 2513 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 2684 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 2833 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 2982 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 3208 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 3357 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 3583 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 3732 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 3958 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 4136 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 4314 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 4492 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 4646 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 4880 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 5034 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 5268 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 5422 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 5656 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 5880 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 6104 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 6288 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 6593 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 6777 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 7082 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 7313 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 7544 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 7733 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 8046 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"









































































#line 8125 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"

#line 8132 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"










#line 8148 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"

#line 8155 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"













































#line 8208 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"

#line 8216 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"

























#line 8548 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 8857 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 9166 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 9483 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 9886 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 10338 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 10749 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 11209 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 11581 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 12076 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 12470 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 12995 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 13351 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 13707 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 14211 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 14737 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 15272 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 15807 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 16179 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 16674 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 17068 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 17593 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 17949 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 18305 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 18809 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 19344 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 19918 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"






#line 20492 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/pin_map.h"

#line 29 ".\\RTE\\_RavenOS_Demo\\RTE_Components.h"
#line 1 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom.h"


















































#line 73 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom.h"






#line 114 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom.h"






#line 403 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom.h"






#line 556 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom.h"






#line 717 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom.h"






#line 788 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom.h"






#line 826 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom.h"






#line 929 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom.h"






#line 1069 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom.h"






#line 1282 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom.h"






#line 1682 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom.h"






#line 1789 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom.h"






#line 1867 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom.h"






#line 2173 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom.h"






#line 2488 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom.h"






#line 2829 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom.h"






#line 2942 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom.h"






#line 3128 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom.h"






#line 3194 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom.h"






#line 3272 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom.h"






#line 3578 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom.h"






#line 3713 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom.h"






#line 3823 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom.h"






#line 4363 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom.h"






#line 4531 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom.h"






#line 4717 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom.h"






#line 5036 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom.h"






#line 5074 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom.h"






#line 5136 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom.h"






#line 5426 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom.h"






#line 5798 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom.h"






#line 6006 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom.h"






#line 6792 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom.h"






#line 6929 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom.h"






#line 6989 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom.h"

#line 30 ".\\RTE\\_RavenOS_Demo\\RTE_Components.h"
#line 1 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/sysctl.h"






























































#line 140 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/sysctl.h"








#line 155 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/sysctl.h"








#line 171 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/sysctl.h"







#line 185 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/sysctl.h"
                                            





















#line 214 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/sysctl.h"







#line 385 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/sysctl.h"







#line 462 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/sysctl.h"

















#line 486 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/sysctl.h"








                                            

                                            











#line 516 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/sysctl.h"






#line 535 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/sysctl.h"















#line 556 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/sysctl.h"


























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










#line 31 ".\\RTE\\_RavenOS_Demo\\RTE_Components.h"
#line 1 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/uart.h"



























































#line 74 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/uart.h"










#line 98 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/uart.h"
































































































extern void UARTParityModeSet(uint32_t ui32Base, uint32_t ui32Parity);
extern uint32_t UARTParityModeGet(uint32_t ui32Base);
extern void UARTFIFOLevelSet(uint32_t ui32Base, uint32_t ui32TxLevel,
                             uint32_t ui32RxLevel);
extern void UARTFIFOLevelGet(uint32_t ui32Base, uint32_t *pui32TxLevel,
                             uint32_t *pui32RxLevel);
extern void UARTConfigSetExpClk(uint32_t ui32Base, uint32_t ui32UARTClk,
                                uint32_t ui32Baud, uint32_t ui32Config);
extern void UARTConfigGetExpClk(uint32_t ui32Base, uint32_t ui32UARTClk,
                                uint32_t *pui32Baud, uint32_t *pui32Config);
extern void UARTEnable(uint32_t ui32Base);
extern void UARTDisable(uint32_t ui32Base);
extern void UARTFIFOEnable(uint32_t ui32Base);
extern void UARTFIFODisable(uint32_t ui32Base);
extern void UARTEnableSIR(uint32_t ui32Base, _Bool bLowPower);
extern void UARTDisableSIR(uint32_t ui32Base);
extern _Bool UARTCharsAvail(uint32_t ui32Base);
extern _Bool UARTSpaceAvail(uint32_t ui32Base);
extern int32_t UARTCharGetNonBlocking(uint32_t ui32Base);
extern int32_t UARTCharGet(uint32_t ui32Base);
extern _Bool UARTCharPutNonBlocking(uint32_t ui32Base, unsigned char ucData);
extern void UARTCharPut(uint32_t ui32Base, unsigned char ucData);
extern void UARTBreakCtl(uint32_t ui32Base, _Bool bBreakState);
extern _Bool UARTBusy(uint32_t ui32Base);
extern void UARTIntRegister(uint32_t ui32Base, void (*pfnHandler)(void));
extern void UARTIntUnregister(uint32_t ui32Base);
extern void UARTIntEnable(uint32_t ui32Base, uint32_t ui32IntFlags);
extern void UARTIntDisable(uint32_t ui32Base, uint32_t ui32IntFlags);
extern uint32_t UARTIntStatus(uint32_t ui32Base, _Bool bMasked);
extern void UARTIntClear(uint32_t ui32Base, uint32_t ui32IntFlags);
extern void UARTDMAEnable(uint32_t ui32Base, uint32_t ui32DMAFlags);
extern void UARTDMADisable(uint32_t ui32Base, uint32_t ui32DMAFlags);
extern uint32_t UARTRxErrorGet(uint32_t ui32Base);
extern void UARTRxErrorClear(uint32_t ui32Base);
extern void UARTSmartCardEnable(uint32_t ui32Base);
extern void UARTSmartCardDisable(uint32_t ui32Base);
extern void UARTModemControlSet(uint32_t ui32Base, uint32_t ui32Control);
extern void UARTModemControlClear(uint32_t ui32Base, uint32_t ui32Control);
extern uint32_t UARTModemControlGet(uint32_t ui32Base);
extern uint32_t UARTModemStatusGet(uint32_t ui32Base);
extern void UARTFlowControlSet(uint32_t ui32Base, uint32_t ui32Mode);
extern uint32_t UARTFlowControlGet(uint32_t ui32Base);
extern void UARTTxIntModeSet(uint32_t ui32Base, uint32_t ui32Mode);
extern uint32_t UARTTxIntModeGet(uint32_t ui32Base);
extern void UARTClockSourceSet(uint32_t ui32Base, uint32_t ui32Source);
extern uint32_t UARTClockSourceGet(uint32_t ui32Base);
extern void UART9BitEnable(uint32_t ui32Base);
extern void UART9BitDisable(uint32_t ui32Base);
extern void UART9BitAddrSet(uint32_t ui32Base, uint8_t ui8Addr,
                            uint8_t ui8Mask);
extern void UART9BitAddrSend(uint32_t ui32Base, uint8_t ui8Addr);










#line 32 ".\\RTE\\_RavenOS_Demo\\RTE_Components.h"
#line 1 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom_map.h"
















































#line 280 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom_map.h"






#line 447 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom_map.h"






#line 572 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom_map.h"






#line 627 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom_map.h"






#line 668 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom_map.h"






#line 786 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom_map.h"






#line 918 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom_map.h"






#line 1148 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom_map.h"






#line 1651 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom_map.h"






#line 1741 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom_map.h"






#line 1810 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom_map.h"






#line 2068 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom_map.h"






#line 2396 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom_map.h"






#line 2759 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom_map.h"






#line 2863 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom_map.h"






#line 3065 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom_map.h"






#line 3120 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom_map.h"






#line 3210 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom_map.h"






#line 3440 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom_map.h"






#line 3551 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom_map.h"






#line 3676 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom_map.h"






#line 4102 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom_map.h"






#line 4255 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom_map.h"






#line 4408 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom_map.h"






#line 4729 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom_map.h"






#line 4763 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom_map.h"






#line 4818 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom_map.h"






#line 5069 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom_map.h"






#line 5383 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom_map.h"






#line 5557 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom_map.h"






#line 6256 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom_map.h"






#line 6374 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom_map.h"






#line 6415 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\driverlib/rom_map.h"

#line 33 ".\\RTE\\_RavenOS_Demo\\RTE_Components.h"
#line 1 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\RTE_Device.h"























 




#line 30 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\RTE_Device.h"
#line 31 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\RTE_Device.h"

#line 33 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\RTE_Device.h"
#line 34 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\RTE_Device.h"
#line 35 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\RTE_Device.h"
#line 36 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\RTE_Device.h"
#line 37 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\RTE_Device.h"
#line 38 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\RTE_Device.h"
#line 39 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\RTE_Device.h"
#line 40 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\RTE_Device.h"
#line 41 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\RTE_Device.h"
#line 42 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\RTE_Device.h"
#line 43 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\RTE_Device.h"
#line 44 "D:\\Keil_v5\\ARM\\PACK\\RavenOS\\TM4C123GH6PM_UART\\1.0.2\\RTE\\CMSIS\\Driver\\Config\\RTE_Device.h"

#line 34 ".\\RTE\\_RavenOS_Demo\\RTE_Components.h"


#line 14 "thread0.c"
uint8_t task_stack_thread0[300]; osThreadDef_t os_thread_def_thread0 = { ( (uint8_t *) &(task_stack_thread0)), (thread0), (osPriorityLow), (300) };  

osThreadId tid_thread0;     
void task0(void);



 
int Init_thread0 (void) 
{
    tid_thread0 = osThreadCreate (&os_thread_def_thread0, 0);
    if(!tid_thread0) return(-1);

    return(0);
}



 
int Terminate_thread0 (void) 
{	
    if (osThreadTerminate(tid_thread0) != osOK)
    {
        return(-1);
    }

    return(0);
}




 
void thread0 (void const *argument) 
{	
		int i = 0;
		  
	while (i<4) 
  {	
			i++;

      printf(" Task5: Hello!\n\r");
					  
			printf("Task5: Locking Server1 ! \n\r");
					
			if (osSemaphoreWait (sid_pce_Semaphore1, 0xFFFFFFFF) >= 0 )
			{
			   printf("Task5: Server1 Locked ! \n\r");
						
				 osThreadSetPriority(osThreadGetId(), osPriorityAboveNormal);
						
				 if (osSemaphoreRelease (sid_Semaphore0) != osOK)
         {
             printf("thread0 failed to release semaphore 0\n\r");
             while(1) { };
         }
						
		  	 if (osSemaphoreRelease (sid_Semaphore3) != osOK)
         {
             printf("thread0 failed to release semaphore 3\n\r");
             while(1) { };
         }
						
	   		 if (osSemaphoreRelease (sid_Semaphore1) != osOK)
         {
              printf("thread0 failed to release semaphore 1\n\r");
              while(1) { };
         }
						
         printf("Task5: Unlocking Server 1 !\n\r");
				 if (osSemaphoreRelease (sid_pce_Semaphore1) != osOK)
         {
							printf("Task5: failed to release semaphore 0!\n\r");
                while(1) { };
         }
								 
				 if (osSemaphoreRelease (sid_Semaphore2) != osOK)
         {
              printf("thread0 failed to release semaphore 2\n\r");
              while(1) { };
         }
			   osThreadSetPriority(osThreadGetId(), osPriorityLow);
		  }
      else
      {
			 	printf("Task5 failed to acquire Server 2\n\r");
        while(1) { };
			}	
      printf("Task5: Bye! \n\r");
					  					
    }
       
	}
