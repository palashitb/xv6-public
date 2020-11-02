// #include <stdio.h>
#include "types.h"
#include "user.h"

int number_of_processes = 5;

int main(int argc, char *argv[])
{
  int start = tick();
  int j;
  for (j = 0; j < number_of_processes; j++)
  {
    int pid = fork();
    if (pid < 0)
    {
      printf(1, "Fork failed\n");
      continue;
    }
    if (pid == 0)
    {
      volatile int i;
      // printf(1, "whoop\n");
      for (volatile int k = 0; k < number_of_processes; k++)
      {
        if (k <= j)
        {
          sleep(200); //io time
        }
        else
        {
          for (i = 0; i < 100000000; i++)
          {
            ; //cpu time
          }
        }
      }
    //   printf(1, "Process: %d Finished\n", j);
      exit();
    }
    else{
      set_priority(pid, 100-(20+j)); // will only matter for PBS, comment it out if not implemented yet (better priorty for more IO intensive jobs)
    }
  }
  for (j = 0; j < number_of_processes+3; j++)
  {
    wait();
  }
  printf(1, "Total time taken to execute is %d\n", tick() - start);
  exit();
}
