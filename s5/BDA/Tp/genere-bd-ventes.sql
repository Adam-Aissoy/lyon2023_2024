begin;

drop schema if exists optimisation cascade;
create schema optimisation;
set search_path to optimisation ;
-------------------------------
	
-- Procédure qui crée :
----- nbtuples clients
----- nbtuples produits
----- jusqu'à 4 commandes par clients  
----- jusqu'à 6 produits par commande ; donc table concerne en moyenne 12*nbtuples
drop procedure if exists rempli_tables;
create procedure rempli_tables(nbtuples integer)
as $$
declare
k			integer;
un_numP		integer;
compt		integer;
une_date	date;
curs_com 	cursor for select DateCom, numc 
				from commandes;
begin



--drop table if exists clients cascade;
create table clients(
	NumC 		integer primary key,
	NomC		varchar(35),
	AdresseC	text
);

--drop table if exists produits cascade;
	create table produits(
	NumP		integer primary key,
	NomP		varchar(35),
	descriptif	text
);

--drop table if exists commandes cascade;
create table commandes(
	DateCom		date,
	NumC		integer ,
	Commentaire	text,
	primary key(DateCom,NumC)
);

--drop table if exists livraisons;
create table livraisons(
	DateLiv		date,
	DateCom		date,
	NumC		Integer,
	Prestataire	varchar,
	primary key(DateLiv,DateCom,NumC)
);

--drop table if exists Concerne;
create table concerne(
	NumP		integer,
	DateCom 	date,
	NumC		integer,
	Quantite	integer,
	primary key (NumP,DateCom,NumC)
);

	
	INSERT INTO clients (numc , nomc , adressec) 
	SELECT g, 'nomc_'||((random() * nbtuples * 4 / 5)::integer)::varchar, md5(g::text)||md5((2*g)::text)||md5((3*g)::text)  
	FROM generate_series(0,nbtuples-1) as g;

	INSERT INTO produits (nump , nomp , descriptif) 
	SELECT g, 'nomp_'||((random() * nbtuples * 4 / 5)::integer)::varchar, md5(g::text)||md5((2*g)::text)||md5((3*g)::text)  
	FROM generate_series(0,nbtuples-1) as g;
	

	for g in 1..4*(nbtuples-1) loop
		une_date = CURRENT_TIMESTAMP - ((random() * 3650)::integer||'day')::interval;
		un_nump=(random()*(nbtuples-1))::integer;
		insert into commandes (DateCom, numc, commentaire) 
			select 	une_date, un_nump, md5(g::text)||md5((2*g)::text)||md5((3*g)::text) on conflict do nothing;
	end loop;
	
	
		for t in curs_com 
		loop
			k=(random() *6)::integer;
			for i in 1..k loop
				un_numP = (random()*(nbtuples-1))::integer;
				insert into concerne (NumP,datecom,numc,quantite)
				values (un_nump,t.Datecom,t.numc,(random()*100)::integer) on conflict do nothing;
				if i>3 then
					une_date = t.datecom+((random() * 30)::integer||'days')::interval;
					insert into livraisons (DateLiv, DateCom, numC, prestataire)
					values(une_date,t.datecom,t.numc,'prest'||((random() *20)::integer)::varchar) on conflict do nothing;
				end if;
			end loop;
		end loop; 

alter table commandes add CONSTRAINT fk_commande_client foreign key (numc) references clients(NumC) on delete cascade not valid;
alter table livraisons add constraint fk_livraison_commande foreign key (DateCom,NumC) references commandes(DateCom,NumC) on delete cascade not valid;
alter table concerne add constraint fk_concerne_commande foreign key (DateCom,NumC) references commandes(DateCom,NumC) on delete cascade not valid;
alter table concerne add constraint fk_concerne_produit	foreign key (NumP) references produits(NumP) not valid;

end;


$$ language plpgsql;

commit;

begin;
do $$
begin
	call optimisation.rempli_tables(100000);
end
$$;
commit;

