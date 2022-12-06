
create table sponsor(
        nom char (15) primary key,
        adresse varchar (20) not null,
        chiffre_affaire integer
);

create table joueur(
        nom char (20) primary key,
        prenom char (15) not null,
        anneenaissance integer not null default 1930,
        nationalite char (15) not null
);

create table gain(
        nom_joueur char (20),
        lieu_tournoi char (20) not null,
        date integer,
        prime integer,
        nom_sponsor char(15),

        primary key (nom_joueur, lieu_tournoi, date),
        
        foreign key (nom_joueur) references joueur (nom),
        foreign key (nom_sponsor) references sponsor (nom)
);

create table rencontre(
        nom_gagnant char (20) ,
        nom_perdant char (20) ,
        lieu_tournoi char (20) not null,
        date integer,
        score char (20),

        primary key (nom_gagnant, nom_perdant, lieu_tournoi, date),

        foreign key (nom_gagnant,lieu_tournoi, date) references gain (nom_joueur, lieu_tournoi, date),
        foreign key (nom_perdant,lieu_tournoi, date) references gain (nom_joueur, lieu_tournoi, date)

);
