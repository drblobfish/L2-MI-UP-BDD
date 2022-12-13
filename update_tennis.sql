
#include <stdlib.h>
#include <stdio.h>

exec sql begin declare section;
    int prime;
    char nom_joueur[21];
exec sql end declare section;

exec sql include sqlca;

int main(){

    exec sql connect to "BDim01231@opale"
    user "im01231" using "testbdd";

    if (sqlca.sqlcode<0){
        printf ("ERREUR CONNECT: %s\n", sqlca.sqlerrm.sqlerrmc);
        }

    exec sql begin;
    if (sqlca.sqlcode<0){
        printf ("ERREUR BEGIN: %s\n", sqlca.sqlerrm.sqlerrmc);
        }

    exec sql update gain
    set prime = prime + 10000
    where lieu_tournoi = 'Roland Garros' and
    nom_joueur in (
        select nom_gagnant
        from rencontre
        where lieu_tournoi = 'Roland Garros'
    );
    exec sql commit;

    exec sql declare C cursor for
    select nom_joueur,prime from gain
    where lieu_tournoi = 'Roland Garros' and
    nom_joueur in (
        select nom_gagnant
        from rencontre
        where lieu_tournoi = 'Roland Garros'
    );

    exec sql open C;

    exec sql fetch from C into :nom_joueur, :prime;
    for (;sqlca.sqlcode == 0;){
        printf("nom : %s\tprime : %d\n", nom_joueur, prime);
        exec sql fetch from C into :nom_joueur, :prime;
    }

    exec sql close C;

    exec sql disconnect;


    return EXIT_SUCCESS;
}