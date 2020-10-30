#include "types.h"
#include "user.h"

int main(){
    int wtime, rtime;
    waitx(&wtime, &rtime);
    printf("%d %d\n", wtime, rtime);
    sleep(10);
    waitx(&wtime, &rtime);
    printf("%d %d\n", wtime, rtime);
    return 0;
}