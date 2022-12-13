/* Processed by ecpg (10.22 (Ubuntu 10.22-0ubuntu0.18.04.1)) */
/* These include files are added by the preprocessor */
#include <ecpglib.h>
#include <ecpgerrno.h>
#include <sqlca.h>
/* End of automatic include section */

#line 1 "update_tennis.sql"

#include <stdlib.h>
#include <stdio.h>

/* exec sql begin declare section */
     
     

#line 6 "update_tennis.sql"
 int prime ;
 
#line 7 "update_tennis.sql"
 char nom_joueur [ 21 ] ;
/* exec sql end declare section */
#line 8 "update_tennis.sql"



#line 1 "/usr/include/postgresql//sqlca.h"
#ifndef POSTGRES_SQLCA_H
#define POSTGRES_SQLCA_H

#ifndef PGDLLIMPORT
#if  defined(WIN32) || defined(__CYGWIN__)
#define PGDLLIMPORT __declspec (dllimport)
#else
#define PGDLLIMPORT
#endif							/* __CYGWIN__ */
#endif							/* PGDLLIMPORT */

#define SQLERRMC_LEN	150

#ifdef __cplusplus
extern "C"
{
#endif

struct sqlca_t
{
	char		sqlcaid[8];
	long		sqlabc;
	long		sqlcode;
	struct
	{
		int			sqlerrml;
		char		sqlerrmc[SQLERRMC_LEN];
	}			sqlerrm;
	char		sqlerrp[8];
	long		sqlerrd[6];
	/* Element 0: empty						*/
	/* 1: OID of processed tuple if applicable			*/
	/* 2: number of rows processed				*/
	/* after an INSERT, UPDATE or				*/
	/* DELETE statement					*/
	/* 3: empty						*/
	/* 4: empty						*/
	/* 5: empty						*/
	char		sqlwarn[8];
	/* Element 0: set to 'W' if at least one other is 'W'	*/
	/* 1: if 'W' at least one character string		*/
	/* value was truncated when it was			*/
	/* stored into a host variable.             */

	/*
	 * 2: if 'W' a (hopefully) non-fatal notice occurred
	 */	/* 3: empty */
	/* 4: empty						*/
	/* 5: empty						*/
	/* 6: empty						*/
	/* 7: empty						*/

	char		sqlstate[5];
};

struct sqlca_t *ECPGget_sqlca(void);

#ifndef POSTGRES_ECPG_INTERNAL
#define sqlca (*ECPGget_sqlca())
#endif

#ifdef __cplusplus
}
#endif

#endif

#line 10 "update_tennis.sql"


int main(){

    { ECPGconnect(__LINE__, 0, "BDim01231@opale" , "im01231" , "testbdd" , NULL, 0); }
#line 15 "update_tennis.sql"


    if (sqlca.sqlcode<0){
        printf ("ERREUR CONNECT: %s\n", sqlca.sqlerrm.sqlerrmc);
        }

    { ECPGtrans(__LINE__, NULL, "begin");}
#line 21 "update_tennis.sql"

    if (sqlca.sqlcode<0){
        printf ("ERREUR BEGIN: %s\n", sqlca.sqlerrm.sqlerrmc);
        }

    { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "update gain set prime = prime + 10000 where lieu_tournoi = 'Roland Garros' and nom_joueur in ( select nom_gagnant from rencontre where lieu_tournoi = 'Roland Garros' )", ECPGt_EOIT, ECPGt_EORT);}
#line 33 "update_tennis.sql"

    { ECPGtrans(__LINE__, NULL, "commit");}
#line 34 "update_tennis.sql"


    /* declare C cursor for select nom_joueur , prime from gain where lieu_tournoi = 'Roland Garros' and nom_joueur in ( select nom_gagnant from rencontre where lieu_tournoi = 'Roland Garros' ) */
#line 43 "update_tennis.sql"


    { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "declare C cursor for select nom_joueur , prime from gain where lieu_tournoi = 'Roland Garros' and nom_joueur in ( select nom_gagnant from rencontre where lieu_tournoi = 'Roland Garros' )", ECPGt_EOIT, ECPGt_EORT);}
#line 45 "update_tennis.sql"


    { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "fetch from C", ECPGt_EOIT, 
	ECPGt_char,(nom_joueur),(long)21,(long)1,(21)*sizeof(char), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, 
	ECPGt_int,&(prime),(long)1,(long)1,sizeof(int), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, ECPGt_EORT);}
#line 47 "update_tennis.sql"

    for (;sqlca.sqlcode == 0;){
        printf("nom : %s\tprime : %d\n", nom_joueur, prime);
        { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "fetch from C", ECPGt_EOIT, 
	ECPGt_char,(nom_joueur),(long)21,(long)1,(21)*sizeof(char), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, 
	ECPGt_int,&(prime),(long)1,(long)1,sizeof(int), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, ECPGt_EORT);}
#line 50 "update_tennis.sql"

    }

    { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "close C", ECPGt_EOIT, ECPGt_EORT);}
#line 53 "update_tennis.sql"


    { ECPGdisconnect(__LINE__, "CURRENT");}
#line 55 "update_tennis.sql"



    return EXIT_SUCCESS;
}