# xv6-public
Enhancing the fate of this noob os

So the few changes made yet are:-
    1. Adding 3 system calls(waitx, ps, set_priority)
    2. Adding 2 user calls(setPriority, setPriority)
    3. Adding 3 more scheduling algorithms along with the default one

Now let's understand how I have made the changes.

SYSTEM CALLS:
(note that changes have to be made in proc.c, user.h, user.S, syscall.c, syscall.h and sysproc.c for each syscall)
    1. waitx(int* wtime, int* rtime)
        logic: The main code resides in proc.c where we just check for the first zombie childs of the calling parent, calculate the wait time by the formula 
            wtime = p -> etime - p -> ctime - p -> rtime
        We return the pid of the child we waited for just like wait command.
        implementation: Busy waiting until a child becomes zombie and then do the calculation and other important arrangements.
        return type: int(pid of child)
    
    2. pls() (this is basically the ps command but with a different name)
        logic: Just check the ptable.proc for process that have existed and print out the usable information.
        Note that there are 2 cases for calculating the wait time of a process due to the possibility of a process current dead or not so.
        implementation: Just a basic for loop and printing information of processes with a pid above zero.
        return type: int(could be void as well but I did for my convenience)
    
    3. set_priority(int pid, int priority)
        logic: Find the process with the given pid and change its priority to the said value. Also return old priority for reference.
        implementation: Simple loop to check for the process with the given id(if it is still existent)
        return type: int(previously held priority for the process)

    
USER CALLS(like the commands in bash/zsh)
(Dont have to do much, just see if required system calls exist. Next, make a c program and make apt changes in makefile to run this c file and get the experience of a user call)

No specific telling required here.

    setPrioirity: Called by c file named "setPriority.c"

    ps: Called by c file named "ps.c"

SCHEDULING ENHANCEMENT
(added FCFS, PBS and MLFQ scheduling algorithms alongwith the default RR algorithm)

    
