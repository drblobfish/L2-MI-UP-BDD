-- h)
select nom_joueur,prime from gain
where nom_sponsor = 'Peugeot' and date <= 1990 and date >= 1985
;



-- i)
select x.nom_joueur,y.anneenaissance from gain x,joueur y
where x.lieu_tournoi = 'Roland Garros' and x.nom_joueur = y.nom and x.date = 1989
;


-- j)
select z.nom_joueur, j.nationalite
from rencontre x, gain z, joueur j
where 
-- jointure gain rencontre 
z.nom_joueur = x.nom_gagnant
--jointure gain joueur
and z.nom_joueur = j.nom
-- condition
and z.nom_sponsor = 'Peugeot' and x.lieu_tournoi = 'Roland Garros'
;

-- k)
--   1)
select y.nom, y.nationalite
from 
joueur y,
(
    select nom_joueur from gain
    where lieu_tournoi = 'Roland Garros' and date = 1985

    intersect

    select nom_joueur from gain
    where lieu_tournoi = 'Wimbledon' and date = 1985
    ) x
where y.nom = x.nom_joueur;

--   2)
select distinct j.nom, j.nationalite
from 
joueur j,
gain g
where 
-- jointure joueur gain
j.nom = g.nom_joueur
-- winbledon
and g.lieu_tournoi = 'Wimbledon' and date = 1985
-- roland
and g.nom_joueur in (
    select nom_joueur from gain where lieu_tournoi = 'Roland Garros' and date = 1985
)
;

select x.nom_joueur from gain x, gain y
where x.nom_joueur = y.nom_joueur and x.date = y.date and x.date = 1985 and
x.lieu_tournoi = 'Roland Garros' and y.lieu_tournoi = 'Wimbledon';


--   3)
select distinct j.nom, j.nationalite
from 
joueur j,
gain g
where 
-- jointure joueur gain
j.nom = g.nom_joueur
-- winbledon
and g.lieu_tournoi = 'Wimbledon' and g.date = 1985
-- roland
and exists (
    select * from gain g2 where g2.nom_joueur = g.nom_joueur  and g2.lieu_tournoi = 'Roland Garros' and g2.date = 1985
)
;

-- l)
--   1)
select nom_joueur from gain
where lieu_tournoi = 'Roland Garros' and prime >= 1000000

EXCEPT

select nom_joueur from gain
where lieu_tournoi = 'Roland Garros' and prime < 1000000
;
--   2)
select nom_joueur from gain
where lieu_tournoi = 'Roland Garros' and prime >= 1000000
and nom_joueur not in (
    select nom_joueur from gain where lieu_tournoi = 'Roland Garros' and prime < 1000000
);

--   3)

select nom from joueur
where (
    select min(prime) from gain 
    where lieu_tournoi = 'Roland Garros' and nom_joueur = nom
    )>= 1000000;

--   4)
select nom_joueur from gain 
where lieu_tournoi = 'Roland Garros'
group by nom_joueur
having min(prime)>=1000000;

--   5)
select x.nom_joueur from gain x
where 1000000 <= all(
    select prime from gain y
    where y.lieu_tournoi = 'Roland Garros' and y.nom_joueur = x.nom_joueur
) and x.lieu_tournoi = 'Roland Garros';

-- m)
--   1)
(
    select nom_gagnant from rencontre where lieu_tournoi = 'Roland Garros'
    except 
    select nom_perdant from rencontre where lieu_tournoi = 'Roland Garros'
    )
intersect 
(
    select nom_perdant from rencontre where lieu_tournoi = 'Wimbledon'
    except 
    select nom_gagnant from rencontre where lieu_tournoi = 'Wimbledon'
    )
;

--   2)
select distinct nom_gagnant from rencontre where
lieu_tournoi = 'Roland Garros' and
nom_gagnant not in (
    select nom_perdant from rencontre where lieu_tournoi = 'Roland Garros'
) and 
nom_gagnant in (
    select nom_perdant from rencontre where lieu_tournoi = 'Wimbledon' and 
    nom_perdant not in (
        select nom_gagnant from rencontre where lieu_tournoi = 'Wimbledon'
    )
);

-- n)
--   1)

select x.nom, x.prenom, y.nom, y.prenom 
from joueur x, joueur y
where 
    exists (
        select * from rencontre where nom_gagnant = x.nom and nom_perdant = y.nom
    ) and 
    not exists (
        select * from rencontre where nom_gagnant = y.nom and nom_perdant = x.nom
    )
;

--   2)
select z.nom_gagnant, x.prenom, z.nom_perdant, y.prenom from 
    (select nom_gagnant, nom_perdant from rencontre
    except
    select nom_perdant, nom_gagnant from rencontre) z,
    joueur x,
    joueur y
where x.nom = z.nom_gagnant and y.nom = z.nom_perdant;


-- o)

--   1)
select nom_joueur from gain
where lieu_tournoi = 'Roland Garros'
group by nom_joueur
having count(distinct date) = (
    select count(distinct date)
    from gain
    where lieu_tournoi = 'Roland Garros'
);

--   2)
select nom_joueur from 
(
    select nom_joueur,count(distinct date) from gain
    where lieu_tournoi = 'Roland Garros'
    group by nom_joueur
    ) x,
(
    select count( distinct date) from gain
    where lieu_tournoi = 'Roland Garros'
    ) y
where x.count = y.count;

--   4)
select nom from joueur
where not exists(
    select date from gain 
    where lieu_tournoi = 'Roland Garros'

    except

    select date from gain
    where lieu_tournoi = 'Roland Garros' and nom_joueur = nom
);

-- p)

select count(distinct nom_joueur) from gain
where lieu_tournoi = 'Wimbledon' and date = 1989;

-- q)

select date, avg(prime) from gain
group by date;

-- r)

select
    nom,
    prenom,
from joueur
order by nom;

select count(y.nom) as numero,x.nom,x.prenom
from joueur x, joueur y
where x.nom >= y.nom
group by x.nom,x.prenom
order by numero;

-- s)

insert into joueur
values ('Herrmann','Jules',2002,'Francais');


-- t)
update joueur 
set anneenaissance = 2020
where nom = 'Herrmann';

-- u)
delete from joueur
where nom = 'Herrmann';

-- v)

--   1)
delete from rencontre
where nom_gagnant = 'Noah' or nom_perdant = 'Noah';

delete from gain
where nom_joueur = 'Noah';

delete from joueur
where nom = 'Noah';

delete from rencontre x, gain y, joueur z
where x.nom_gagnant = 'Noah' or x.nom_perdant = 'Noah'
and y.nom_joueur = 'Noah'
and z.nom = 'Noah';

--   2)

/* On cherche à mettre l'option ON DELETE CASCADE sur la 
contrainte de clé étrangère du gain */

alter table gain
drop constraint gain_nom_joueur_fkey;

alter table gain 
add foreign key (nom_joueur) references joueur (nom)
on delete cascade;

alter table rencontre
drop constraint rencontre_nom_gagnant_fkey;

alter table rencontre
add foreign key (nom_gagnant,lieu_tournoi,date) references gain (nom_joueur,lieu_tournoi,date)
on delete cascade;

alter table rencontre
drop constraint rencontre_nom_perdant_fkey;

alter table rencontre
add foreign key (nom_perdant, lieu_tournoi, date) references gain (nom_joueur, lieu_tournoi, date)
on delete cascade;

/* Après on peut utiliser  */

delete from joueur
where nom = 'Noah';

-- x)

delete from joueur
where (
    select sum(prime) from gain
    where nom_joueur = nom
) < 200000;


-- y)

/* 
Modifications à effectuer :
- créer la table tournoi
- la remplir avec les valeurs de tout les tournois présents dans la base
- enlever les 2 clé étrangère de rencontre
- ajouter à gain un clé étrangère référant lieu_tournoi et date à la table
  tournoi
- ajouter à rencontre une clé étrangère référant lieu_tournoi et date à la 
  table tournoi
*/

create table tournoi (
    lieu_tournoi char (20) not null,
    date integer
);

insert into tournoi (lieu_tournoi,date)
select distinct lieu_tournoi, date
from gain
;

alter table tournoi
add primary key (lieu_tournoi,date);

alter table rencontre
drop constraint rencontre_nom_perdant_fkey;

alter table rencontre
drop constraint rencontre_nom_gagnant_fkey;

alter table rencontre
add foreign key (lieu_tournoi,date) references tournoi (lieu_tournoi,date)
on delete cascade;

alter table rencontre
add foreign key (nom_gagnant) references joueur (nom)
on delete cascade;

alter table rencontre
add foreign key (nom_perdant) references joueur (nom)
on delete cascade;

alter table gain
add foreign key (lieu_tournoi,date) references tournoi (lieu_tournoi,date)
on delete cascade;

