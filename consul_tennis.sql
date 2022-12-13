
#include<stdio.h>
#include <stdlib.h>

exec sql begin declare section;
    char nom[21];
    int anneenaissance;
exec sql end declare section;

exec sql include sqlca;

int main(){

    exec sql connect to "BDim01231@opale"
    user "im01231" using "testbdd";

    if (sqlca.sqlcode<0){
        printf ("ERREUR CONNECT: %s\n", sqlca.sqlerrm.sqlerrmc);
        }

    exec sql declare C cursor
    for select nom, anneenaissance from joueur;

    exec sql open C;
    if (sqlca.sqlcode<0){
        printf ("ERREUR OPEN CURSOR: %s\n", sqlca.sqlerrm.sqlerrmc);
        }

    exec sql fetch from C into :nom, :anneenaissance;
    for (;sqlca.sqlcode == 0;){
        printf("nom : %s\tdate de naissance : %d\n", nom, anneenaissance);
        exec sql fetch from C into :nom, :anneenaissance;
    }

    exec sql close C;

    exec sql disconnect;
    return EXIT_SUCCESS;
}