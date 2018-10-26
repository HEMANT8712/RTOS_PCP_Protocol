#line 1 "RTE\\RTOS\\Source\\semaphores.c"




#line 1 ".\\RTE\\RTOS\\Include\\RavenOS.h"



 






















































 






















































































 


















#line 173 ".\\RTE\\RTOS\\Include\\RavenOS.h"

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
	osPriority                 priority;      
	osThreadId                 thread_info;   
	uint32_t                   resource_id;   
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






















#line 467 ".\\RTE\\RTOS\\Include\\RavenOS.h"















osThreadId osThreadCreate ( osThreadDef_t *thread_def, void *argument);



void osInsertRTRQ( os_tcb_p th );
void osRemoveRTRQ( os_tcb_p th );




osThreadId osThreadGetId (void);





osStatus osThreadTerminate (osThreadId thread_id);




osStatus osThreadYield (void);






osStatus osThreadSetPriority (osThreadId thread_id, osPriority priority);





osPriority osThreadGetPriority (osThreadId thread_id);








osStatus osDelay (uint32_t millisec);

#line 536 ".\\RTE\\RTOS\\Include\\RavenOS.h"








#line 552 ".\\RTE\\RTOS\\Include\\RavenOS.h"














osTimerId osTimerCreate (const osTimerDef_t *timer_def, os_timer_type type, void *argument);






osStatus osTimerStart (osTimerId timer_id, uint32_t millisec);





osStatus osTimerStop (osTimerId timer_id);





osStatus osTimerDelete (osTimerId timer_id);









int32_t osSignalSet (osThreadId thread_id, int32_t signals);






int32_t osSignalClear (osThreadId thread_id, int32_t signals);






osEvent osSignalWait (int32_t signals, uint32_t millisec);








#line 625 ".\\RTE\\RTOS\\Include\\RavenOS.h"












osMutexId osMutexCreate (const osMutexDef_t *mutex_def);






osStatus osMutexWait (osMutexId mutex_id, uint32_t millisec);





osStatus osMutexRelease (osMutexId mutex_id);





osStatus osMutexDelete (osMutexId mutex_id);










#line 674 ".\\RTE\\RTOS\\Include\\RavenOS.h"




















osSemaphoreId osSemaphoreCreate (osSemaphoreDef_t *semaphore_def, int32_t count);






int32_t osSemaphoreWait (osSemaphoreId semaphore_id, uint32_t millisec);





osStatus osSemaphoreRelease (osSemaphoreId semaphore_id);






osStatus osSemaphoreDelete (osSemaphoreId semaphore_id);






int32_t PCP_Semaphore_Wait (osSemaphoreId semaphore_id, uint32_t millisec);





osStatus PCP_Semaphore_Release (osSemaphoreId semaphore_id);












#line 790 ".\\RTE\\RTOS\\Include\\RavenOS.h"




#line 841 ".\\RTE\\RTOS\\Include\\RavenOS.h"




#line 912 ".\\RTE\\RTOS\\Include\\RavenOS.h"






#line 6 "RTE\\RTOS\\Source\\semaphores.c"
#line 1 "D:\\Keil_v5\\ARM\\ARMCC\\Bin\\..\\include\\stdlib.h"
 
 
 




 
 



 






   














  


 








#line 54 "D:\\Keil_v5\\ARM\\ARMCC\\Bin\\..\\include\\stdlib.h"


  



    typedef unsigned int size_t;    
#line 70 "D:\\Keil_v5\\ARM\\ARMCC\\Bin\\..\\include\\stdlib.h"






    



    typedef unsigned short wchar_t;  
#line 91 "D:\\Keil_v5\\ARM\\ARMCC\\Bin\\..\\include\\stdlib.h"

typedef struct div_t { int quot, rem; } div_t;
    
typedef struct ldiv_t { long int quot, rem; } ldiv_t;
    

typedef struct lldiv_t { long long quot, rem; } lldiv_t;
    


#line 112 "D:\\Keil_v5\\ARM\\ARMCC\\Bin\\..\\include\\stdlib.h"
   



 

   




 
#line 131 "D:\\Keil_v5\\ARM\\ARMCC\\Bin\\..\\include\\stdlib.h"
   


 
extern __declspec(__nothrow) int __aeabi_MB_CUR_MAX(void);

   




 

   




 




extern __declspec(__nothrow) double atof(const char *  ) __attribute__((__nonnull__(1)));
   



 
extern __declspec(__nothrow) int atoi(const char *  ) __attribute__((__nonnull__(1)));
   



 
extern __declspec(__nothrow) long int atol(const char *  ) __attribute__((__nonnull__(1)));
   



 

extern __declspec(__nothrow) long long atoll(const char *  ) __attribute__((__nonnull__(1)));
   



 


extern __declspec(__nothrow) double strtod(const char * __restrict  , char ** __restrict  ) __attribute__((__nonnull__(1)));
   

















 

extern __declspec(__nothrow) float strtof(const char * __restrict  , char ** __restrict  ) __attribute__((__nonnull__(1)));
extern __declspec(__nothrow) long double strtold(const char * __restrict  , char ** __restrict  ) __attribute__((__nonnull__(1)));
   

 

extern __declspec(__nothrow) long int strtol(const char * __restrict  ,
                        char ** __restrict  , int  ) __attribute__((__nonnull__(1)));
   



























 
extern __declspec(__nothrow) unsigned long int strtoul(const char * __restrict  ,
                                       char ** __restrict  , int  ) __attribute__((__nonnull__(1)));
   


























 

 
extern __declspec(__nothrow) long long strtoll(const char * __restrict  ,
                                  char ** __restrict  , int  )
                          __attribute__((__nonnull__(1)));
   




 
extern __declspec(__nothrow) unsigned long long strtoull(const char * __restrict  ,
                                            char ** __restrict  , int  )
                                   __attribute__((__nonnull__(1)));
   



 

extern __declspec(__nothrow) int rand(void);
   







 
extern __declspec(__nothrow) void srand(unsigned int  );
   






 

struct _rand_state { int __x[57]; };
extern __declspec(__nothrow) int _rand_r(struct _rand_state *);
extern __declspec(__nothrow) void _srand_r(struct _rand_state *, unsigned int);
struct _ANSI_rand_state { int __x[1]; };
extern __declspec(__nothrow) int _ANSI_rand_r(struct _ANSI_rand_state *);
extern __declspec(__nothrow) void _ANSI_srand_r(struct _ANSI_rand_state *, unsigned int);
   


 

extern __declspec(__nothrow) void *calloc(size_t  , size_t  );
   



 
extern __declspec(__nothrow) void free(void *  );
   





 
extern __declspec(__nothrow) void *malloc(size_t  );
   



 
extern __declspec(__nothrow) void *realloc(void *  , size_t  );
   













 

extern __declspec(__nothrow) int posix_memalign(void **  , size_t  , size_t  );
   









 

typedef int (*__heapprt)(void *, char const *, ...);
extern __declspec(__nothrow) void __heapstats(int (*  )(void *  ,
                                           char const *  , ...),
                        void *  ) __attribute__((__nonnull__(1)));
   










 
extern __declspec(__nothrow) int __heapvalid(int (*  )(void *  ,
                                           char const *  , ...),
                       void *  , int  ) __attribute__((__nonnull__(1)));
   














 
extern __declspec(__nothrow) __declspec(__noreturn) void abort(void);
   







 

extern __declspec(__nothrow) int atexit(void (*  )(void)) __attribute__((__nonnull__(1)));
   




 
#line 436 "D:\\Keil_v5\\ARM\\ARMCC\\Bin\\..\\include\\stdlib.h"


extern __declspec(__nothrow) __declspec(__noreturn) void exit(int  );
   












 

extern __declspec(__nothrow) __declspec(__noreturn) void _Exit(int  );
   







      

extern __declspec(__nothrow) char *getenv(const char *  ) __attribute__((__nonnull__(1)));
   









 

extern __declspec(__nothrow) int  system(const char *  );
   









 

extern  void *bsearch(const void *  , const void *  ,
              size_t  , size_t  ,
              int (*  )(const void *, const void *)) __attribute__((__nonnull__(1,2,5)));
   












 
#line 524 "D:\\Keil_v5\\ARM\\ARMCC\\Bin\\..\\include\\stdlib.h"


extern  void qsort(void *  , size_t  , size_t  ,
           int (*  )(const void *, const void *)) __attribute__((__nonnull__(1,4)));
   









 

#line 553 "D:\\Keil_v5\\ARM\\ARMCC\\Bin\\..\\include\\stdlib.h"

extern __declspec(__nothrow) __attribute__((const)) int abs(int  );
   



 

extern __declspec(__nothrow) __attribute__((const)) div_t div(int  , int  );
   









 
extern __declspec(__nothrow) __attribute__((const)) long int labs(long int  );
   



 




extern __declspec(__nothrow) __attribute__((const)) ldiv_t ldiv(long int  , long int  );
   











 







extern __declspec(__nothrow) __attribute__((const)) long long llabs(long long  );
   



 




extern __declspec(__nothrow) __attribute__((const)) lldiv_t lldiv(long long  , long long  );
   











 
#line 634 "D:\\Keil_v5\\ARM\\ARMCC\\Bin\\..\\include\\stdlib.h"




 
typedef struct __sdiv32by16 { int quot, rem; } __sdiv32by16;
typedef struct __udiv32by16 { unsigned int quot, rem; } __udiv32by16;
    
typedef struct __sdiv64by32 { int rem, quot; } __sdiv64by32;

__value_in_regs extern __declspec(__nothrow) __attribute__((const)) __sdiv32by16 __rt_sdiv32by16(
     int  ,
     short int  );
   

 
__value_in_regs extern __declspec(__nothrow) __attribute__((const)) __udiv32by16 __rt_udiv32by16(
     unsigned int  ,
     unsigned short  );
   

 
__value_in_regs extern __declspec(__nothrow) __attribute__((const)) __sdiv64by32 __rt_sdiv64by32(
     int  , unsigned int  ,
     int  );
   

 




 
extern __declspec(__nothrow) unsigned int __fp_status(unsigned int  , unsigned int  );
   







 























 
extern __declspec(__nothrow) int mblen(const char *  , size_t  );
   












 
extern __declspec(__nothrow) int mbtowc(wchar_t * __restrict  ,
                   const char * __restrict  , size_t  );
   















 
extern __declspec(__nothrow) int wctomb(char *  , wchar_t  );
   













 





 
extern __declspec(__nothrow) size_t mbstowcs(wchar_t * __restrict  ,
                      const char * __restrict  , size_t  ) __attribute__((__nonnull__(2)));
   














 
extern __declspec(__nothrow) size_t wcstombs(char * __restrict  ,
                      const wchar_t * __restrict  , size_t  ) __attribute__((__nonnull__(2)));
   














 

extern __declspec(__nothrow) void __use_realtime_heap(void);
extern __declspec(__nothrow) void __use_realtime_division(void);
extern __declspec(__nothrow) void __use_two_region_memory(void);
extern __declspec(__nothrow) void __use_no_heap(void);
extern __declspec(__nothrow) void __use_no_heap_region(void);

extern __declspec(__nothrow) char const *__C_library_version_string(void);
extern __declspec(__nothrow) int __C_library_version_number(void);











#line 892 "D:\\Keil_v5\\ARM\\ARMCC\\Bin\\..\\include\\stdlib.h"





 
#line 7 "RTE\\RTOS\\Source\\semaphores.c"
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



 

#line 8 "RTE\\RTOS\\Source\\semaphores.c"
#line 1 ".\\RTE\\RTOS\\Include\\kernel.h"



 




#line 10 ".\\RTE\\RTOS\\Include\\kernel.h"
#line 11 ".\\RTE\\RTOS\\Include\\kernel.h"


 

	

void os_KernelInvokeScheduler (void);
void os_KernelStackAlloc (os_tcb_p thread_p);


extern os_tcb_p curr_task;               




#line 9 "RTE\\RTOS\\Source\\semaphores.c"










osSemaphoreId sem_list_h = 0;                 
uint32_t sem_cnt = 0;                 




osSemaphoreId CurrentCeilingPCPsemaphore = 0; 
osSemaphoreId PCP_resource_list[2]={0}; 




osStatus os_RemoveThreadFromSemaphoreBlockedQ (osThreadId thread_id, osSemaphoreId semaphore_id);
osStatus os_InsertThreadInSemaphoreBlockedQ (osThreadId thread_id, osSemaphoreId semaphore_id, uint32_t expiryTime, uint32_t ticks);
uint32_t os_SearchThreadInSemaphoreBlockedQ (osThreadId thread_id, osSemaphoreId semaphore_id);
osStatus os_SearchThreadAllSemaphoresBlockedQ (osThreadId thread_id, osSemaphoreId* semaphore_id_p, uint32_t* semaphore_p_p );

void PCP_deallocation(osSemaphoreId semaphore_id); 
int32_t PCP_allocation(osSemaphoreId semaphore_id);



void blockedWalk( osSemaphoreId semaphore_id )
{
	
	
	os_tcb_p *checkHere;  
	for ( checkHere = &( semaphore_id->blocked_q_h ); *checkHere != 0; checkHere = &( (*checkHere)->blocked_q_p ) ) 
	{
		if( *checkHere != 0 )
		{
			continue;
		}
		
	}
}





void osInsertBlockedQ( osSemaphoreId semaphore_id, os_tcb_p th_p )
{
	os_tcb_p *checkHere;  
	
	for ( checkHere = &( semaphore_id->blocked_q_h ); *checkHere != 0; checkHere = &( (*checkHere)->blocked_q_p ) ) 
	{
		if ( (*checkHere)->priority <= th_p->priority )
		{
			
			break;
		}
	}
	
	
	th_p->blocked_q_p = *checkHere;
	
	*checkHere = th_p;
	
	semaphore_id->blocked_q_cnt++;
	
	
}




void osRemoveBlockedQ( osSemaphoreId semaphore_id, os_tcb_p th_p )
{
		os_tcb_p *checkHere;  
	
	for ( checkHere = &( semaphore_id->blocked_q_h ); *checkHere != 0; checkHere = &( (*checkHere)->blocked_q_p ) ) 
	{
		if ( *checkHere == th_p )
		{
			
			break;
		}
	}
	
	if ( *checkHere != 0 )   
	{
		
		(*checkHere)->blocked_q_p = th_p->blocked_q_p;
		
		semaphore_id->blocked_q_cnt--;
	}
	
}




osThreadId osRemoveFromHeadOfBlockedQ( osSemaphoreId semaphore_id )
{
	osThreadId temp;
	
	if ( semaphore_id->blocked_q_h == 0 )
	{
		return ( 0 );
	}
	
	
	temp = semaphore_id->blocked_q_h;
	
	
  semaphore_id->blocked_q_h = temp->blocked_q_p;
  
	temp->blocked_q_p = 0;
	
	semaphore_id->blocked_q_cnt--;
	
	
	
	return( temp );
}









osSemaphoreId osSemaphoreCreate ( osSemaphoreDef_t *semaphore_def, int32_t count)
	{  

  
	semaphore_def->blocked_q_h = 0;
	semaphore_def->blocked_q_cnt = 0;
	semaphore_def->ownCount = count;
	
	
	semaphore_def->next = sem_list_h;
  sem_list_h = semaphore_def;		
	sem_cnt++;

	return semaphore_def;
}







int32_t osSemaphoreWait (osSemaphoreId semaphore_id, uint32_t millisec)
{	
	uint64_t microsec = ((uint64_t) millisec) * 1000;
	uint32_t ticks = 0, wait = 0;
	osThreadId curr_th = osThreadGetId();
	
	
	if ( semaphore_id == 0 )
	{
		return (-1);
	}	

		
	if ( millisec != 0xFFFFFFFF )
	{
		return (-1);			
	}
	
	if ( --( semaphore_id->ownCount ) >= 0 )
	{
		
		
		return (semaphore_id->ownCount);
	}	
	
	
  if ( millisec == 0 )
	{
		
		return (-1);			
	}

	
	
	
	
	curr_th->status = TH_BLOCKED;
	
	osRemoveRTRQ( curr_task );
	
	if (0xFFFFFFFF == millisec)
	{			
		if (os_InsertThreadInSemaphoreBlockedQ(curr_th, semaphore_id, 0xFFFFFFFF, 0xFFFFFFFF) != osOK)
		{
			return (-1); 
		}			
	}
	else   	
	{
		ticks = (uint32_t) (((uint64_t)microsec * (1000)) / 1000000);
		wait = ticks + osKernelSysTick();
		if (os_InsertThreadInSemaphoreBlockedQ(curr_th, semaphore_id, wait, ticks) != osOK)
		{
			return (-1); 
		}	
	}			
	
	
	
	os_KernelInvokeScheduler ();						

	
	
	if ( semaphore_id->ownCount  < 0 )
	{
     return (0);
	}
	else
	{
		  return ( semaphore_id->ownCount );
	}
	
}






osStatus osSemaphoreRelease (osSemaphoreId semaphore_id)
{
	osThreadId th_p;    
	
	if ( semaphore_id == 0 )
	{ 
		return osErrorParameter;
	}

	semaphore_id->ownCount++;  
	
	
	if (semaphore_id->blocked_q_cnt == 0)    	
	{
		
		return osOK;
	}
	
	
	th_p = osRemoveFromHeadOfBlockedQ( semaphore_id );
	
	
	
	th_p->status = TH_RUNNING;
	
	
	osInsertRTRQ( th_p  );
	
	
	os_KernelInvokeScheduler ();					

	return osOK;
}







osStatus osSemaphoreDelete (osSemaphoreId semaphore_id)
{
	

 
	return osOK;
}








osStatus os_InsertThreadInSemaphoreBlockedQ (osThreadId thread_id, osSemaphoreId semaphore_id, uint32_t expiryTime, uint32_t ticks)
{
	if ( thread_id == 0)
	{
		return osErrorParameter;
	}
	if (semaphore_id == 0)
	{
		return osErrorParameter;
	}		
	
	thread_id->semaphore_id = semaphore_id;
	
	osInsertBlockedQ( semaphore_id, thread_id );
	
	return osOK;
}






uint32_t os_SearchThreadInSemaphoreBlockedQ (osThreadId thread_id, osSemaphoreId semaphore_id)
{
	
 
	return 0;    
}









osStatus os_SearchThreadAllSemaphoresBlockedQ (osThreadId thread_id, osSemaphoreId* semaphore_id_p, uint32_t* semaphore_p_p )
{
	
 
	return osOK;
}






void PCP_deallocation(osSemaphoreId semaphore_id)
{
	osThreadId curr_th = osThreadGetId();
	uint32_t cnt = 0, id = 0; 
	osPriority max_priority = osPriorityIdle;
	semaphore_id->ownCount++;  
	
	curr_th->priority = curr_th->tpriority; 
	semaphore_id->thread_info = 0;
	
	  PCP_resource_list[semaphore_id->resource_id - 1] = 	0;
	
	if(CurrentCeilingPCPsemaphore == semaphore_id)
	{	
	  CurrentCeilingPCPsemaphore = 0; 
	  
	  for(cnt=0; cnt < 2; cnt++)
 	  { 
		  if ((PCP_resource_list[cnt]!= 0) && (PCP_resource_list[cnt]->priority > max_priority))
	 	  {
	  	 	id = cnt; 
		  	max_priority = PCP_resource_list[cnt]->priority; 
	  	}	
    }
    CurrentCeilingPCPsemaphore = PCP_resource_list[id]; 
	}
}





int32_t PCP_allocation (osSemaphoreId semaphore_id)
{
	osThreadId curr_th = osThreadGetId(); 
	
	
	if ((CurrentCeilingPCPsemaphore == 0) || (curr_th->priority > CurrentCeilingPCPsemaphore->priority) || 
		  (CurrentCeilingPCPsemaphore->thread_info == curr_th))
	{
		
		 if ((CurrentCeilingPCPsemaphore == 0) ||(semaphore_id->priority > CurrentCeilingPCPsemaphore->priority))
		 {
			 CurrentCeilingPCPsemaphore = semaphore_id;
	 	 }
		 
 	    semaphore_id->thread_info =  curr_th; 
	    
			PCP_resource_list[semaphore_id->resource_id - 1] = 	semaphore_id;					
	    
	    
			--(semaphore_id->ownCount);
     return (semaphore_id->ownCount);
  }
   
	 return (-1);
}





int32_t PCP_Semaphore_Wait (osSemaphoreId semaphore_id, uint32_t millisec)
{	
	osThreadId curr_th = osThreadGetId();
	int32_t retVal = 0;
	
	if ( semaphore_id == 0 )
	{
		return (-1);
	}		
	  
	  if ( semaphore_id->ownCount  > 0 )
	  {
			
			retVal = PCP_allocation(semaphore_id);
      if(-1 != retVal)
			{
        return(retVal);
			}				  				
    }
		
		
		
		if(CurrentCeilingPCPsemaphore->thread_info->priority < curr_th->priority)
    {
      CurrentCeilingPCPsemaphore->thread_info->priority = curr_th->priority;
			osRemoveRTRQ (CurrentCeilingPCPsemaphore->thread_info);
	    osInsertRTRQ (CurrentCeilingPCPsemaphore->thread_info );
    }			
	
	
	
	curr_th->status = TH_BLOCKED;
	
	osRemoveRTRQ( curr_task );
	
		if (os_InsertThreadInSemaphoreBlockedQ(curr_th, semaphore_id, 0xFFFFFFFF, 0xFFFFFFFF) != osOK)
		{
			return (-1); 
		}			
	
	
	os_KernelInvokeScheduler ();						
	
	if ( semaphore_id->ownCount  <= 0 )
	{
     return (0);
	}
	else
	{	   
		  retVal = PCP_allocation(semaphore_id);
      if(-1 != retVal)
			{
        return(retVal);
			}
			else
			{
				return(0);
      }
	}	
}





osStatus PCP_Semaphore_Release (osSemaphoreId semaphore_id)
{
	osThreadId th_p;    
	osThreadId curr_th = osThreadGetId();
	if ( semaphore_id == 0 )
	{ 
		return osErrorParameter;
	}
	PCP_deallocation(semaphore_id);   
	
	osRemoveRTRQ (curr_th);
	osInsertRTRQ( curr_th );
		
	
	if (semaphore_id->blocked_q_cnt == 0)    	
	{		
		return osOK;
	}	
	
	th_p = osRemoveFromHeadOfBlockedQ( semaphore_id );	
	
	
	th_p->status = TH_RUNNING;	
	
	osInsertRTRQ( th_p  );	
	
	os_KernelInvokeScheduler ();					
	return osOK;
}


