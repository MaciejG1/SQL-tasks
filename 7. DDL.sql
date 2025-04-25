--Polecenie zad 1--
--Korzystając z poniższego polecenia odwołującego się do danych zawartych w słowniku bazy danych (katalogu) wyświetl strukturę relacji FILMY.

SELECT column_name, data_type, character_maximum_length chml, numeric_precision np FROM information_schema.columns WHERE table_name = 'filmy'

--Polecenie zad 2--
--Utwórz relację KSIAZKI o następującej strukturze:
--a. ID_KSIAZKI – liczba całkowita
--b. TYTUL – łańcuch znakowy, maksymalnie 30 znaków (zmienna dł.)
--c. AUTOR – łańcuch znakowy, maksymalnie 30 znaków (zmienna dł.)
--d. ROK_WYDANIA – liczba całkowita.--

CREATE TABLE ksiazki (id_ksiazki int,tytul varchar(30), autor varchar(30),rok_wydania int);

--Polecenie zad 3--
--Wstaw dwie nowe krotki do relacji KSIAZKI.--

INSERT INTO ksiazki VALUES(1, 'Pan Tadeusz', 'Adam Mickiewicz', 1995);
INSERT INTO ksiazki VALUES(2, 'Krzyzacy', 'Henryk Sienkiewicz', 1990);

--Polecenie zad 4--
--Wyświetl strukturę relacji KSIAZKI.--

SELECT column_name, data_type, character_maximum_length chml, numeric_precision np FROM information_schema.columns WHERE table_name= 'ksiazki';

--Polecenie zad 5--
--Usuń relację KSIAZKI.--

DROP TABLE ksiazki;

--Polecenie zad 6--
--Utwórz relację OSOBY o następującej strukturze:
--a. PESEL łańcuch znakowy 11-znakowy (stała dł.)
--b. IMIE łańcuch znakowy 15-znakowy (zmienna dł.)
--c. NAZWISKO łańcuch znakowy 15-znakowy (zmienna dł.)
--d. DATA_URODZENIA data
--Ponadto, podczas tworzenia nowej relacji zdefiniuj następujące ograniczenia integralnościowe:
--e. PESEL musi liczyć dokładnie 11 znaków
--f. pierwsze dwie cyfry numeru PESEL muszą być takie same, jak ostatnie dwie cyfry roku w atrybucie DATA_URODZENIA
--g. kolejne dwie cyfry numery PESEL muszą być takie same, jak numer miesiąca w atrybucie DATA_URODZENIA
--h. kolejne dwie cyfry numeru PESEL muszą być takie same, jak numer dnia w atrybucie DATA_URODZENIA
--i. atrybut PESEL jest kluczem głównym relacji
--j. atrybuty IMIĘ i NAZWISKO muszą być wypełnione (niepuste)--

CREATE TABLE osoby ( 
pesel char(11), 
imie varchar(15) not null, 
nazwisko varchar(15) not null, 
data_urodzenia date,
primary key(pesel), 
constraint walidacja_pesel check (
length(pesel)=11
and substring(pesel, 1, 2) = to_char(data_urodzenia, 'YY') 
and substring(pesel, 3, 2) = to_char(data_urodzenia, 'MM') 
and substring(pesel, 5, 2) = to_char(data_urodzenia, 'DD'))
);


--Polecenie zad 7--
--Do relacji OSOBY wstaw następujące krotki. Które z operacji zakończyły się niepowodzeniem? Dlaczego?
--a. ‘39090100001’,’Jan’,’Kowalski’,’1939-09-01’
--b. ‘750218’,’Adam’,’Nowak’,’1975-02-18’
--c. ‘75021800123’,’Adam’,’Nowak’,’1975-02-20’
--d. ‘75021800123’,’Adam’,’Nowak’,’1975-02-18’--

--ok
INSERT INTO osoby VALUES('39090100001','Jan','Kowalski','1939-09-01'); 
--Zbyt krotki numer pesel
INSERT INTO osoby VALUES('750218','Adam','Nowak','1975-02-18');
--zla data urodzenia w stosunku do nr pesel 
INSERT INTO osoby VALUES('75021800123','Adam','Nowak','1975-02-20'); 
-- ok
INSERT INTO osoby VALUES('75021800123','Adam','Nowak','1975-02-18');


--Polecenie zad 8--
--Utwórz relację FAKTURY o następującej strukturze:
--a. NUMER liczba całkowita, generowana automatycznie, klucz główny
--b. PESEL łańcuch znakowy 11-znakowy, klucz obcy do relacji OSOBY
--c. KWOTA liczba rzeczywista 8-cyfrowa, 2 cyfry po przecinku, większa od zera--

CREATE TABLE faktury (
numer serial,
pesel char(11),
kwota numeric(8,2),
foreign key (pesel) references osoby,
primary key (numer));


--Polecenie zad 9--
--Do relacji FAKTURY wstaw następujące krotki. Które z operacji zakończyły się niepowodzeniem? Dlaczego?
--a. PESEL=’39090100001’, KWOTA=123.45
--b. PESEL=’39090199999’, KWOTA=678.90
--c. PESEL=’39090100001’, KWOTA=1234567890
--d. PESEL=‘75021800123’
--e. NUMER=1, PESEL=’39090100001’, KWOTA=123.45--
--ok
INSERT INTO faktury (pesel,kwota) VALUES ('39090100001', 123.45);
--brak referencji do osoby
INSERT INTO faktury (pesel,kwota) VALUES ('39090199999', 678.90); --zadanie 9
--zla forma kwoty
INSERT INTO faktury (pesel,kwota) VALUES ('39090100001', 1234567890);
--ok
INSERT INTO faktury (pesel) VALUES ('75021800123');
--powtórzenie istniejącego klucza
INSERT INTO faktury VALUES (1,'75021800123',123.45);

--Polecenie zad 10--
--Wyświetl pełną zawartość relacji FAKTURY.--

SELECT * FROM faktury;

--Polecenie zad 11--
--Wyświetl numery faktur i figurujące na nich kwoty. W przypadku braku kwoty faktury wyświetl 0.--

SELECT numer,COALESCE(kwota,0) FROM faktury;

--Polecenie zad 12--
--Wyświetl numery faktur i numery PESEL dla tych faktur, na których zabrakło kwoty.--

SELECT numer,pesel FROM faktury WHERE kwota=0;

--Polecenie zad 13--
--Z relacji OSOBY usuń krotkę opisującą osobę o imieniu ‘Jan’. Co się stało? Dlaczego?--

delete FROM osoby WHERE imie='Jan';
--błąd dotyczący referencji do tabeli osoby
--Polecenie zad 14--
--W relacji FAKTURY w dowolny sposób zmodyfikuj numer PESEL osoby o imieniu ‘Jan’. Co się stało?--

UPDATE faktury SET pesel='39090100002' WHERE numer= 1;

--Polecenie zad 15--
--Usuń relację OSOBY.--

DROP TABLE osoby CASCADE;

--Polecenie zad 16--
--Usuń relację FAKTURY.--

DROP TABLE faktury;

--Polecenie zad 17--
--Utwórz relację MOJE_FILMY o takiej samej strukturze jak istniejąca relacja FILMY.--

CREATE TABLE moje_filmy(id_filmu int, tytul varchar(40), rok_produkcji int, cena real);

--Polecenie zad 18--
--Z relacji FILMY przekopiuj do relacji MOJE_FILMY te krotki, które dotyczą filmów wyprodukowanych przed rokiem 1990. Sprawdź zawartość relacji MOJE_FILMY.--

INSERT INTO moje_filmy SELECT * FROM filmy WHERE rok_produkcji<1990;

--Polecenie zad 19--
--Usuń relację FILMY--

DROP TABLE filmy;

--Polecenie zad 20--
--Do relacji FILMY dodaj nowy atrybut o nazwie CENA_EURO typu REAL.--

ALTER TABLE filmy ADD column cena_euro real;

--Polecenie zad 21--
--Zmodyfikuj wszystkie krotki relacji FILMY tak, aby atrybut CENA_EURO zawierał wartość atrybutu CENA podzieloną przez 4.--

UPDATE filmy SET cena_euro= (cena/4);

--Polecenie zad 22--
--W relacji FILMY zmień nazwę atrybutu CENA_EURO na EUROCENA.--

ALTER TABLE filmy RENAME column cena_euro to eurocena;

--Polecenie zad 23--
--Z relacji FILMY usuń atrybut o nazwie EUROCENA--

ALTER TABLE filmy DROP column eurocena;

--Polecenie zad 24--
--Do relacji FILMY wprowadź nową krotkę o następujących wartościach atrybutów: ID_FILMU=11, TYTUL=’Vabank’. Pozostałe atrybuty pozostaw niewypełnione.--

INSERT INTO filmy (id_filmu,tytul) VALUES (11,'vabank');

--Polecenie zad 25--
--Wyświetl tytuły wszystkich filmów, które nie posiadają żadnej wartości w atrybucie ROK_PRODUKCJI.--

SELECT tytul FROM filmy WHERE rok_produkcji is null;

--Polecenie zad 26--
--Wyświetl tytuły i ceny wszystkich filmów. W przypadku filmów, które nie posiadają żadnej wartości w atrybucie CENA, wyświetl zero.--

SELECT tytul, COALESCE(cena, 0) FROM filmy;

--Polecenie zad 27--
--Z relacji FILMY usuń wszystkie krotki, które nie posiadają wartości w atrybutach ROK_PRODUKCJI i CENA.--

delete FROM filmy WHERE rok_produkcji is null and cena is null;
