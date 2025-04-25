--Polecenie zad 1--
--Wyświetl wspólną listę nazwisk wszystkich klientów i wszystkich aktorów. Wynik uporządkuj alfabetycznie.--

SELECT nazwisko FROM klienci UNION SELECT nazwisko FROM aktorzy ORDER BY nazwisko;

--Polecenie zad 2--
--Wyświetl tytuły filmów, w których razem zagrali aktorzy o nazwiskach ‘De Niro’ i ‘Reno’.--

SELECT tytul FROM filmy NATURAL JOIN obsada NATURAL JOIN aktorzy WHERE nazwisko='De Niro' INTERSECT
SELECT tytul FROM filmy NATURAL JOIN obsada NATURAL JOIN aktorzy WHERE nazwisko='Reno'

--Polecenie zad 3--
--Wyświetl tytuły tych filmów, które były wypożyczane zarówno przez klienta o nazwisku ‘Kowalski’, jak i przez klienta o nazwisku ‘Nowak’.--

SELECT tytul FROM filmy NATURAL JOIN kopie NATURAL JOIN wypozyczenia NATURAL JOIN klienci WHERE nazwisko='Kowalski' INTERSECT
SELECT tytul FROM filmy NATURAL JOIN kopie NATURAL JOIN wypozyczenia NATURAL JOIN klienci WHERE nazwisko='Nowak';

--Polecenie zad 4--
--Wyświetl tytuły tych filmów, które były wypożyczane przez klienta o nazwisku ‘Kowalski’, a zarazem nigdy nie były wypożyczane przez klienta o nazwisku ‘Nowak’.--

SELECT tytul FROM filmy NATURAL JOIN kopie NATURAL JOIN wypozyczenia NATURAL JOIN klienci WHERE nazwisko='Kowalski' EXCEPT
SELECT tytul FROM filmy NATURAL JOIN kopie NATURAL JOIN wypozyczenia NATURAL JOIN klienci WHERE nazwisko='Nowak';

--Polecenie zad 5--
--Wyświetl nazwiska aktorów, którzy zagrali w filmie pt. ‘Terminator’, a jednocześnie nie zagrali w filmie pt. ‘Ghostbusters’.--

SELECT nazwisko FROM aktorzy NATURAL JOIN obsada NATURAL JOIN filmy WHERE tytul='Terminator' EXCEPT
SELECT nazwisko FROM aktorzy NATURAL JOIN obsada NATURAL JOIN filmy WHERE tytul='GhostBusters';

