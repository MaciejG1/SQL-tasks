--Polecenie zad 1--
--Dla każdej kopii wyświetl jej identyfikator i tytuł zapisanego na niej filmu. Wynik uporządkuj według identyfikatorów kopii.--

SELECT id_kopii,tytul FROM filmy NATURAL JOIN kopie;

--Polecenie zad 2--
--Wyświetl tytuły wszystkich filmów, których kopie są aktualnie dostępne w wypożyczalni. Wyeliminuj duplikaty.--

SELECT DISTINCT tytul FROM filmy NATURAL JOIN kopie WHERE czy_dostepna='T' ORDER BY tytul; 

--Polecenie zad 3--
--Wyświetl identyfikatory kopii zawierających filmy wyprodukowane w roku 1984.--

SELECT id_kopii FROM kopie NATURAL JOIN filmy WHERE rok_produkcji=1984;

--Polecenie zad 4--
--Dla każdego wypożyczenia wyświetl datę wypożyczenia, datę zwrotu oraz nazwisko klienta, który dokonał wypożyczenia.--

SELECT data_wypozyczenia,data_zwrotu,nazwisko FROM wypozyczenia NATURAL JOIN klienci;

--Polecenie zad 5--
--Dla każdego wypożyczenia wyświetl nazwisko klienta, który dokonał wypożyczenia oraz tytuł wypożyczonego filmu.--

SELECT nazwisko,tytul FROM wypozyczenia NATURAL JOIN klienci NATURAL JOIN filmy NATURAL JOIN kopie;

--Polecenie zad 6--
--Wyświetl tytuły i lata produkcji wszystkich filmów wypożyczonych przez klienta o nazwisku ‘Kowalski’.--

SELECT tytul,rok_produkcji FROM filmy NATURAL JOIN kopie NATURAL JOIN wypozyczenia NATURAL JOIN klienci WHERE nazwisko='Kowalski';

--Polecenie zad 7--
--Wyświetl nazwisko klienta, który dokonał pierwszego wypożyczenia w historii wypożyczalni.--

SELECT nazwisko FROM wypozyczenia NATURAL JOIN klienci ORDER BY data_wypozyczenia LIMIT 1;

--Polecenie zad 8--
--Wyświetl nazwiska aktorów, którzy zagrali w filmie pt. ‘Terminator’.--

SELECT nazwisko FROM aktorzy NATURAL JOIN obsada NATURAL JOIN filmy WHERE tytul = 'Terminator';

--Polecenie zad 9--
--Wyświetl tytuły wszystkich filmów, w których zagrał aktor o nazwisku ‘De Niro’.--

SELECT tytul FROM aktorzy NATURAL JOIN obsada NATURAL JOIN filmy WHERE nazwisko = 'De Niro';

--Polecenie zad 10--
--Wyświetl tytuł filmu, który był wypożyczony na najdłuższy okres czasu.--

SELECT tytul FROM wypozyczenia NATURAL JOIN kopie NATURAL JOIN filmy ORDER BY (data_zwrotu - data_wypozyczenia) DESC LIMIT 1;

--Polecenie zad 11--
--Wyświetl nazwiska klientów, którzy dokonali wypożyczeń pomiędzy ‘2005-07-15’ a ‘2005-07-20’. Wyeliminuj duplikaty.--

SELECT DISTINCT nazwisko FROM klienci NATURAL JOIN wypozyczenia WHERE data_wypozyczenia BETWEEN '2005-07-15' AND '2005-07-20';

--Polecenie zad 12--
--Wyświetl tytuły filmów wypożyczonych pomiędzy ‘2005-07-15’ a ‘2005-07-25’. Wyeliminuj duplikaty.--

SELECT DISTINCT tytul FROM filmy NATURAL JOIN kopie NATURAL JOIN wypozyczenia WHERE data_wypozyczenia BETWEEN '2005-07-15' AND '2005-07-25';

--Polecenie zad 13--
--Dla klientów, którzy noszą takie same imiona, jak któryś z aktorów, wyświetl: wspólne imię, nazwisko klienta, nazwisko aktora.--

SELECT klienci.imie,klienci.nazwisko,aktorzy.nazwisko FROM aktorzy JOIN klienci ON klienci.imie = aktorzy.imie;
