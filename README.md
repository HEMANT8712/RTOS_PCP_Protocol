# RTOS_PCP_Protocol


Implement the Priority Ceiling Protocol (as described in class (PCP slides)) into RavenOSV2.
The PCP behaviour should be integrated into a new type of RavenOS object called PCPSemaphores. PCPSemaphores are similar to the existing RavenOS Semaphores, except that 1) they assume that binary semaphores are being used (i.e. semaphores in which the max. semaphore owncount is 1) and 2) they support PCP behaviour associated with osPCPSemaphoreWait and osPCPSemaphoreRelease.

Project is tested on Arm 7 Processor.
