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

select nom from joueur
where not exists(
    select * from rencontre where 
    nom_gagnant != nom and nom_perdant != nom
);




