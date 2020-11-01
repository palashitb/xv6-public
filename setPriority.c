#include "types.h"
#include "user.h"
#include "stat.h"
#include "fs.h"
// #include "stdlib.h"

int main(int argc, char *argv[]){
    // char **end;
    // int pid = strtol(args[1], end, 10);
    // int priority = strtol(args[0], end, 10);
    int pid = atoi(argv[2]);
    int priority = atoi(argv[1]);
    set_priority(pid, priority);
    exit();
}