
# TP SQL

```
select nom_joueur,prime from gain
where nom_sponsor = 'Peugeot' and date <= 1990 and date >= 1985
;
```


```
select x.nom_joueur,y.anneenaissance from gain x,joueur y
where x.lieu_tournoi = 'Roland Garros' and x.nom_joueur = y.nom and x.date = 1989
;
```

```
select y.nom,y.nationalite
from rencontre x,joueur y, gain z
where x.nom_gagnant = y.nom and x.lieu_tournoi = 'Roland Garros'
and z.nom_joueur = y.nom and z.date = x.date and z.nom_sponsor = 'Peugeot'
;
```