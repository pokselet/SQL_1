-- Baza danych "filharmonia" składa się z czterach tabel podstwowych: "utwor", "kompozytor", "instrument", "wykonawca" i jednej pomocniczej "utwor_instrument"
-- kompozytor - utwor      => jeden do wielu
-- wykonawca  - instrument => jeden do wielu
-- utwor      - instrument => wiele do wielu => tabela pomocnicza utwor_instrument
-- create database filharmonia;
use filharmonia;
show tables;

drop table if exists kompozytor;
create table kompozytor
(
    id       int         primary key,
    imię     varchar(50),
    nazwisko varchar(50)
);
drop table if exists utwor;
create table utwor
(
    id               int primary key,
    nazwa            varchar(50),
    czas_trwania_min int,
    kompozytor_id    int,
    foreign key (kompozytor_id)references kompozytor(id)
);
drop table if exists instrument;
create table instrument
(
    id    int primary key auto_increment,
    nazwa varchar(40)
);
drop table if exists wykonawca;
create table wykonawca
(
    id            int primary key auto_increment,
    imie          varchar(30),
    nazwisko      varchar(30),
    instrument_id char references instrument(id)
);
drop table if exists utwor_instrument;
create table utwor_instrument
(
    utwor_id      int,
    instrument_id int,
    foreign key (utwor_id)references utwor(id),
    foreign key (instrument_id)references instrument(id),
    primary key (utwor_id, instrument_id)
);


insert into kompozytor(id, imię, nazwisko)
values                (1, 'George', 'Gershwin'),
                      (2, 'Aleksander', 'Tansman'),
                      (3, 'Leonard', 'Bernstein'),
                      (4, 'Georges', 'Bizet');
drop table kompozytor;
delete from utwor;
insert into utwor(id, nazwa, czas_trwania_min, kompozytor_id)
values             (1, 'Uwertura kubańska', 10, 1),
		   (2, 'III Symfonia - Symfonia koncertująca', 26, 2),
	           (3, 'Tance symfoniczne z West Side Story', 22, 3),
                   (4, 'fragmenty z suit orkiestrowych Arlezjanka', 23, 4);
delete from instrument;
insert into instrument(id, nazwa)
values           (1, 'skrzypce'),
		 (2, 'altówka'),
	         (3, 'wielenczela'),
                 (4, 'fortepian'),
                 (5, 'trójkąt'),
                 (6, 'kontrabas');
                 
insert into instrument(id, nazwa)
values           (5, 'flet');

delete from utwor_instrument;
insert into utwor_instrument(utwor_id, instrument_id)
values           (1, 1),
		 (1, 2),
		 (1, 4),
                 (2, 1),
		 (2, 4),
		 (2, 3), 
                 (3, 1),
		 (3, 3),
		 (4, 4),
                 (4, 1);
delete from wykonawca;
insert into wykonawca(id, imie, nazwisko, instrument_id)
values               (1,'Maria', 'Machowska', 1),
		     (2, 'Marek', 'Iwański', 2),
		     (3, 'Robert', 'Putowski', 3),
                     (4, 'Grzegorz', 'Gorczyca', 4),
                     (5, 'Grzegorz', 'Gorczyca', 4);
                     
insert into wykonawca  (id, imie, nazwisko)
values                 (5,'Łukasz', 'Bartczak');

select * from utwor
join kompozytor on utwor.kompozytor_id = kompozytor.id;

use filharmonia;
show tables;
select * from utwor_instrument;

select nazwa, imię, nazwisko from utwor                     -- zwraca tytuł utoru z imieniem i nazwiskiem kompozytora
join kompozytor on utwor.kompozytor_id = kompozytor.id;     

select imie, nazwisko, instrument.nazwa as instrument from wykonawca -- zwraca imię i nazwisko wykonawca oraz instrument, na którym gra
join instrument on wykonawca.instrument_id = instrument.id
order by nazwisko;

select instrument.nazwa as instrument -- zwraca instrumenty grające w Uwerturze kubańskiej
from instrument
right join utwor_instrument as u_i on u_i.instrument_id = instrument.id
right join utwor on u_i.utwor_id = utwor.id
where utwor.nazwa = "Uwertura kubańska";




 
