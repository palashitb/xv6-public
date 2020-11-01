#include "types.h"
#include "user.h"
#include "stat.h"
#include "fs.h"

int main(int argc, char *argv[]){
    if( argc != 3 ){
        printf(1, "Inapt number of command line arguments\n");
        exit();
    }
    int pid = atoi(argv[2]);
    int priority = atoi(argv[1]);
    set_priority(pid, priority);
    exit();
}