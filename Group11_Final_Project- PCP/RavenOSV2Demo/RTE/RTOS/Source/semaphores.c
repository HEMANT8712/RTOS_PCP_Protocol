/// \file semaphores.c
/// \brief Semaphore implementation according to CMSIS interfaces
/// \details Defines a semaphore and semaphore creation and attributes manipulation

#include "RavenOS.h" 
#include <stdlib.h>
#include <stdio.h>
#include "kernel.h"

//=========MACRO================
///MAX number of PCP Semaphore Resources
/// Must be updated for more Servers
#define PCP_MAX_RESOURCE  2

//  ==== Semaphore Management Functions ====

// ******* Persistant data for managing semaphores  *******
// semaphores managed in a list; sem_cnt = number of semaphores in list 
osSemaphoreId sem_list_h = NULL;                 ///< pointer to head of semaphore list, initially empty
uint32_t sem_cnt = 0;                 ///< Semaphore counter

//<<<NEW UPDATED COE>>>
//pointer to current PCP ceiling resource.Its Priority is current ceiling priority of
// of system at time t and its thread_info gives info about thread holding current ceiling resource. 
osSemaphoreId CurrentCeilingPCPsemaphore = NULL; 
osSemaphoreId PCP_resource_list[PCP_MAX_RESOURCE]={0}; //Active PCP resource List
// ******* End of Persistant data *******


// Prototypes
osStatus os_RemoveThreadFromSemaphoreBlockedQ (osThreadId thread_id, osSemaphoreId semaphore_id);
osStatus os_InsertThreadInSemaphoreBlockedQ (osThreadId thread_id, osSemaphoreId semaphore_id, uint32_t expiryTime, uint32_t ticks);
uint32_t os_SearchThreadInSemaphoreBlockedQ (osThreadId thread_id, osSemaphoreId semaphore_id);
osStatus os_SearchThreadAllSemaphoresBlockedQ (osThreadId thread_id, osSemaphoreId* semaphore_id_p, uint32_t* semaphore_p_p );
//<<<NEW UPDATED COE>>>
void PCP_deallocation(osSemaphoreId semaphore_id); //Deallocation rules for PCP resource
int32_t PCP_allocation(osSemaphoreId semaphore_id);//Allocation Rules for PCP resource when resource is free
// Semaphore blocked queue support functions

// used only for debugging
void blockedWalk( osSemaphoreId semaphore_id )
{
	// a debugging function ... only called to validate blocked contents using debugger
	// walk the blocked queue exposing contents
	os_tcb_p *checkHere;  // pointer to a blockedQ pointer/index
	for ( checkHere = &( semaphore_id->blocked_q_h ); *checkHere != NULL; checkHere = &( (*checkHere)->blocked_q_p ) ) 
	{
		if( *checkHere != NULL )
		{
			continue;
		}
		
	}
}

/// Priority insert thread into Blocked Q
/// \param[in]     th_p    pointer to thread tcb 
/// \return        none
/// \note inserts thread before any lower or equal priority threads
void osInsertBlockedQ( osSemaphoreId semaphore_id, os_tcb_p th_p )
{
	os_tcb_p *checkHere;  // pointer to a pointer/index
	// walk the blocked Q looking for the pointer to modify
	for ( checkHere = &( semaphore_id->blocked_q_h ); *checkHere != NULL; checkHere = &( (*checkHere)->blocked_q_p ) ) 
	{
		if ( (*checkHere)->priority <= th_p->priority )
		{
			// found pointer to modify!
			break;
		}
	}
	// checkHere points to the pointer to be modified
	// save link to rest of list
	th_p->blocked_q_p = *checkHere;
	// insert the new thread here
	*checkHere = th_p;
	// increm,ent number of threads in blocked Q
	semaphore_id->blocked_q_cnt++;
	
	// uncomment to invoke      blockedWalk( semaphore_id );  // just for debug
}

/// Remove thread from blocked Q. If thread not in blocked Q ... does not change Q.
/// \param[in]     th    pointer to thread tcb
/// \return        none
void osRemoveBlockedQ( osSemaphoreId semaphore_id, os_tcb_p th_p )
{
		os_tcb_p *checkHere;  // pointer to a RTRQ pointer/index
	// walk the blocked Q looking for the pointer to modify
	for ( checkHere = &( semaphore_id->blocked_q_h ); *checkHere != NULL; checkHere = &( (*checkHere)->blocked_q_p ) ) 
	{
		if ( *checkHere == th_p )
		{
			// found RTRQ pointer to modify!
			break;
		}
	}
	// checkHere points to the pointer/index to be modified, or th was not in Q
	if ( *checkHere != NULL )   // only remove if th is in list
	{
		// save link to rest of list
		(*checkHere)->blocked_q_p = th_p->blocked_q_p;
		// decrement count of threads in Q
		semaphore_id->blocked_q_cnt--;
	}
	// uncomment to invoke      blockedWalk( semaphore_id );  // just for debug
}

/// Remove thread from head of blocked Q. If no thread in blocked Q ... does not change Q.
/// \param[in]     semaphore_id  get thread from this semaphore
/// \return        th_p pointer to removed thread tcb (NULL if no thread removed)
osThreadId osRemoveFromHeadOfBlockedQ( osSemaphoreId semaphore_id )
{
	osThreadId temp;
	// make sure there is something to remove
	if ( semaphore_id->blocked_q_h == NULL )
	{
		return ( NULL );
	}
	
	// save (index) id of thread being removed
	temp = semaphore_id->blocked_q_h;
	
	// save link to rest of q
  semaphore_id->blocked_q_h = temp->blocked_q_p;
  // clear link in removed thread ... just to be safe
	temp->blocked_q_p = NULL;
	// decrement number of threads in Q
	semaphore_id->blocked_q_cnt--;
	
	// uncomment to invoke      blockedWalk( semaphore_id );  // just for debug
	
	return( temp );
}



/// Create and Initialize a Semaphore object used for managing resources.
/// \param[in]     semaphore_def semaphore definition referenced with \ref osSemaphore.
/// \param[in]     count         number of available resources.
/// \return semaphore ID for reference by other functions or NULL in case of error.
/// \note MUST REMAIN UNCHANGED: \b osSemaphoreCreate shall be consistent in every CMSIS-RTOS.
/// \note: RavenOS using def struct as scb ... removed "const" from input param
osSemaphoreId osSemaphoreCreate ( osSemaphoreDef_t *semaphore_def, int32_t count)
	{  //TWPV4: major change: def struct replaces previous scb struct

  // initialize semaphore's internal variables	
	semaphore_def->blocked_q_h = NULL;
	semaphore_def->blocked_q_cnt = 0;
	semaphore_def->ownCount = count;
	
	// add semaphore to semaphore list  ... placed at head (easy)
	semaphore_def->next = sem_list_h;
  sem_list_h = semaphore_def;		
	sem_cnt++;

	return semaphore_def;
}


/// Wait until a Semaphore token becomes available.
/// \param[in]     semaphore_id  semaphore object referenced with \ref osSemaphoreCreate.
/// \param[in]     millisec      timeout value or 0 in case of not willing to wait.
/// \return number of available tokens, or -1 in case of incorrect parameters.
/// \note MUST REMAIN UNCHANGED: \b osSemaphoreWait shall be consistent in every CMSIS-RTOS.
int32_t osSemaphoreWait (osSemaphoreId semaphore_id, uint32_t millisec)
{	
	uint64_t microsec = ((uint64_t) millisec) * 1000;
	uint32_t ticks = 0, wait = 0;
	osThreadId curr_th = osThreadGetId();
	
	// semaphore does not exist
	if ( semaphore_id == NULL )
	{
		return (-1);
	}	

		// timed waiting not supported in this version
	if ( millisec != osWaitForever )
	{
		return (-1);			
	}
	
	if ( --( semaphore_id->ownCount ) >= 0 )
	{
		// semaphore is free -> take semaphore
		// TWP the returned value is not really reliable by the time the released thread runs
		return (semaphore_id->ownCount);
	}	
	
	// timed waiting not supported in this version
  if ( millisec == 0 )
	{
		// all tokens taken for this semaphore, but can't wait, so return unsuccessful
		return (-1);			
	}

	// if still here, then semaphore locked ... need to block calling thread!
	// add thread to the semaphore queue, mark thread as blocked and invoke scheduler  
	
	// set thread to blocked state and manipulate RTRQ and blocked Q before yield
	curr_th->status = TH_BLOCKED;
	// remove from RTRQ
	osRemoveRTRQ( curr_task );
	// put in blocked Q
	if (osWaitForever == millisec)
	{			
		if (os_InsertThreadInSemaphoreBlockedQ(curr_th, semaphore_id, osWaitForever, osWaitForever) != osOK)
		{
			return (-1); // something went wrong and cannot block on this semaphore   TWP :-(   whaaatt?
		}			
	}
	else   	// timed waiting not supported in this version
	{
		ticks = (uint32_t) osKernelSysTickMicroSec(microsec);
		wait = ticks + osKernelSysTick();
		if (os_InsertThreadInSemaphoreBlockedQ(curr_th, semaphore_id, wait, ticks) != osOK)
		{
			return (-1); // something went wrong and cannot block on this semaphore   TWP :-(   whaaatt?   
		}	
	}			
	
	//have modified RTRQ and semaphore blocked Q
	// curr_task is no longer at head of RTRQ ... invoke scheduler to do context switch
	os_KernelInvokeScheduler ();						

	// will eventually resume here when thread released from semaphore ...
	
	if ( semaphore_id->ownCount  < 0 )
	{
     return (0);
	}
	else
	{
		  return ( semaphore_id->ownCount );
	}
	
}


/// Release a Semaphore token.
/// \param[in]     semaphore_id  semaphore object referenced with \ref osSemaphoreCreate.
/// \return status code that indicates the execution status of the function.
/// \note MUST REMAIN UNCHANGED: \b osSemaphoreRelease shall be consistent in every CMSIS-RTOS.
osStatus osSemaphoreRelease (osSemaphoreId semaphore_id)
{
	osThreadId th_p;    // used if releasing a thread
	
	if ( semaphore_id == NULL )
	{ // semaphore does not exist
		return osErrorParameter;
	}

	semaphore_id->ownCount++;  // increment semaphore's current ownCount
	
	// any threads blocked on semaphore?
	if (semaphore_id->blocked_q_cnt == 0)    	
	{
		// EASY case:  no threads blocked on this semaphore
		return osOK;
	}
	
	// unblock the thread with highest priority waiting in the semaphore queue
	th_p = osRemoveFromHeadOfBlockedQ( semaphore_id );
	
	// change state to RUNNING
	//TWPV6: removed TH_READY state ... only using TH_RUNNING 
	th_p->status = TH_RUNNING;
	
	// put the thread in the RTRQ
	osInsertRTRQ( th_p  );
	
	// RTRQ has changed - invoke scheduler for context switch if necessary
	os_KernelInvokeScheduler ();					

	return osOK;
}


// Semaphore deletion is not supported in this version
/// Delete a Semaphore that was created by \ref osSemaphoreCreate.
/// \param[in]     semaphore_id  semaphore object referenced with \ref osSemaphoreCreate.
/// \return status code that indicates the execution status of the function.
/// \note MUST REMAIN UNCHANGED: \b osSemaphoreDelete shall be consistent in every CMSIS-RTOS.
osStatus osSemaphoreDelete (osSemaphoreId semaphore_id)
{
	/*  functionality not supported in this version 
	
	*/
	return osOK;
}


/// Insert thread in the blocked semaphore queue.
/// \param     thread_id  thread object. <-- this ins't needed ... could just use curr_task
/// \param     semaphore_id  semaphore object
/// \param     expiryTime to  give up waiting on semaphore
/// \param     ticks to spend on semaphore
/// \return status code that indicates the execution status of the function.
osStatus os_InsertThreadInSemaphoreBlockedQ (osThreadId thread_id, osSemaphoreId semaphore_id, uint32_t expiryTime, uint32_t ticks)
{
	if ( thread_id == NULL)
	{
		return osErrorParameter;
	}
	if (semaphore_id == NULL)
	{
		return osErrorParameter;
	}		
	
	thread_id->semaphore_id = semaphore_id;
	
	osInsertBlockedQ( semaphore_id, thread_id );
	
	return osOK;
}

//TWPV2 this next function should be no longer needed
/// Remove thread from a blocked semaphore queue.
/// \param     thread_id  thread object.
/// \param     semaphore_id  semaphore object.
/// \return the index within the semaphore queue; MAX_THREADS_SEM is not found or error
uint32_t os_SearchThreadInSemaphoreBlockedQ (osThreadId thread_id, osSemaphoreId semaphore_id)
{
	/*  functionality no longer used ... code removed due to significant changes
	*/
	return 0;    // just a dummy return value for now
}


//TWPV2 this next function should be no longer needed
/// Search for the thread in all blocked semaphore queue.
/// \param     thread_id  thread object.
/// \param     semaphore_id_p  pointer to semaphore object for returning
/// \param     semaphore_p_p  pointer to index to semaphore object for returning
/// \return index withing one of the semaphores the thread is blocked; 
///   - MAX_THREADS_SEM if not found or error
osStatus os_SearchThreadAllSemaphoresBlockedQ (osThreadId thread_id, osSemaphoreId* semaphore_id_p, uint32_t* semaphore_p_p )
{
	/*  functionality no longer used ... code removed due to significant changes
	*/
	return osOK;
}

//<<<NEW UPDATED COE>>>
////// Priority Ceiling Protocol Deallocation Rule.
/// \param[in]     semaphore_id  semaphore object referenced with \ref osSemaphoreCreate.
/// \return status code that indicates the execution status of the function.
/// \note MUST REMAIN UNCHANGED: \b PCP_deallocation shall be consistent in every CMSIS-RTOS.
void PCP_deallocation(osSemaphoreId semaphore_id)
{
	osThreadId curr_th = osThreadGetId();//current thread info
	uint32_t cnt = 0, id = 0; //Maintain count and resource id
	osPriority max_priority = osPriorityIdle;//used to search highest priority ceiling resource
	semaphore_id->ownCount++;  // increment semaphore's current ownCount
	//updating Priority of current thread to its original priority
	curr_th->priority = curr_th->tpriority; 
	semaphore_id->thread_info = NULL;
	//Clearing the resource from the Active PCP resource List
	  PCP_resource_list[semaphore_id->resource_id - 1] = 	NULL;
	//if the PCP Resource is equal to current ceiling priority resource 
	if(CurrentCeilingPCPsemaphore == semaphore_id)
	{	
	  CurrentCeilingPCPsemaphore = NULL; //CLearing Current PCP Resource info
	  //Now locating the id of Active PCP semaphore which has highest ceiling peiority  
	  for(cnt=0; cnt < PCP_MAX_RESOURCE; cnt++)
 	  { //if list is not NULL and its priority higher then max_priority
		  if ((PCP_resource_list[cnt]!= NULL) && (PCP_resource_list[cnt]->priority > max_priority))
	 	  {
	  	 	id = cnt; //storing resource id 
		  	max_priority = PCP_resource_list[cnt]->priority; //updating max_priority			
	  	}	
    }
    CurrentCeilingPCPsemaphore = PCP_resource_list[id]; //update Current Ceiling Priority Resource 	
	}
}
/// Priority Ceiling Protocol Allocation Rules when resource is free.
/// \param[in]     semaphore_id  semaphore object referenced with \ref osSemaphoreCreate.
/// \param[in]     millisec      timeout value or 0 in case of not willing to wait.
/// \return number of available tokens, or -1 in case of incorrect parameters.
/// \note MUST REMAIN UNCHANGED: \b osSemaphoreWait shall be consistent in every CMSIS-RTOS.
int32_t PCP_allocation (osSemaphoreId semaphore_id)
{
	osThreadId curr_th = osThreadGetId(); //Current thread in execution
	//when current thread priority higher then ceiling priority of system or
	//when current thread is the thread holding ceiling priority of system resource then	 
	if ((CurrentCeilingPCPsemaphore == NULL) || (curr_th->priority > CurrentCeilingPCPsemaphore->priority) || 
		  (CurrentCeilingPCPsemaphore->thread_info == curr_th))
	{
		// update ceiling Current Ceiling PCP resource of system if priority is greater
		 if ((CurrentCeilingPCPsemaphore == NULL) ||(semaphore_id->priority > CurrentCeilingPCPsemaphore->priority))
		 {
			 CurrentCeilingPCPsemaphore = semaphore_id;
	 	 }
		 //Store thread info in the semaphore structure 
 	    semaphore_id->thread_info =  curr_th; 
	    //store resource info in the Active PCP resource list		
			PCP_resource_list[semaphore_id->resource_id - 1] = 	semaphore_id;					
	    // semaphore is free -> take semaphore
	    // TWP the returned value is not really reliable by the time the released thread runs
			--(semaphore_id->ownCount);
     return (semaphore_id->ownCount);
  }
   //otherwise return No resource will be allocated  
	 return (-1);
}
/// Wait until a PCP Semaphore token becomes available.
/// \param[in]     semaphore_id  semaphore object referenced with \ref osSemaphoreCreate.
/// \param[in]     millisec      timeout value or 0 in case of not willing to wait.
/// \return number of available tokens, or -1 in case of incorrect parameters.
/// \note MUST REMAIN UNCHANGED: \b osSemaphoreWait shall be consistent in every CMSIS-RTOS.
int32_t PCP_Semaphore_Wait (osSemaphoreId semaphore_id, uint32_t millisec)
{	
	osThreadId curr_th = osThreadGetId();
	int32_t retVal = 0;
	// semaphore does not exist
	if ( semaphore_id == NULL )
	{
		return (-1);
	}		
	  //PCP resource is free
	  if ( semaphore_id->ownCount  > 0 )
	  {
			//Implementation of PCP Allocation Rules
			retVal = PCP_allocation(semaphore_id);
      if(-1 != retVal)
			{
        return(retVal);
			}				  				
    }
		//Updating the priority of thread holding the resource with ceiling
		//priority when resource is not available or thread has lower priority 
		//then the ceiling priority of system.
		if(CurrentCeilingPCPsemaphore->thread_info->priority < curr_th->priority)
    {
      CurrentCeilingPCPsemaphore->thread_info->priority = curr_th->priority;
			osRemoveRTRQ (CurrentCeilingPCPsemaphore->thread_info);
	    osInsertRTRQ (CurrentCeilingPCPsemaphore->thread_info );
    }			
	// if still here, then semaphore locked ... need to block calling thread!
	// add thread to the semaphore queue, mark thread as blocked and invoke scheduler  	
	// set thread to blocked state and manipulate RTRQ and blocked Q before yield
	curr_th->status = TH_BLOCKED;
	// remove from RTRQ
	osRemoveRTRQ( curr_task );
	// put in blocked Q
		if (os_InsertThreadInSemaphoreBlockedQ(curr_th, semaphore_id, osWaitForever, osWaitForever) != osOK)
		{
			return (-1); // something went wrong and cannot block on this semaphore   TWP :-(   whaaatt?
		}			
	//have modified RTRQ and semaphore blocked Q
	// curr_task is no longer at head of RTRQ ... invoke scheduler to do context switch
	os_KernelInvokeScheduler ();						
	// will eventually resume here when thread released from semaphore ...	
	if ( semaphore_id->ownCount  <= 0 )
	{
     return (0);
	}
	else
	{	   //Implementation of PCP Allocation Rules when Server is free
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

/// Release a PCP Resource token.
/// \param[in]     semaphore_id  semaphore object referenced with \ref osSemaphoreCreate.
/// \return status code that indicates the execution status of the function.
/// \note MUST REMAIN UNCHANGED: \b osSemaphoreRelease shall be consistent in every CMSIS-RTOS.
osStatus PCP_Semaphore_Release (osSemaphoreId semaphore_id)
{
	osThreadId th_p;    // Active if releasing a thread
	osThreadId curr_th = osThreadGetId();
	if ( semaphore_id == NULL )
	{ // semaphore does not exist
		return osErrorParameter;
	}
	PCP_deallocation(semaphore_id);   //PCP Deallocation Rules
	//Schedule Decision the is made due to change in priority of process 
	osRemoveRTRQ (curr_th);
	osInsertRTRQ( curr_th );
		
	// any threads blocked on semaphore?
	if (semaphore_id->blocked_q_cnt == 0)    	
	{		// EASY case:  no threads blocked on this semaphore
		return osOK;
	}	
	// unblock the thread with highest priority waiting in the semaphore queue
	th_p = osRemoveFromHeadOfBlockedQ( semaphore_id );	
	// change state to RUNNING
	//TWPV6: removed TH_READY state ... only using TH_RUNNING 
	th_p->status = TH_RUNNING;	
	// put the thread in the RTRQ
	osInsertRTRQ( th_p  );	
	// RTRQ has changed - invoke scheduler for context switch if necessary
	os_KernelInvokeScheduler ();					
	return osOK;
}


