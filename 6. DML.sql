--Polecenie zad 1--
--Do relacji FILMY wstaw nową krotkę: id_filmu=11, tytul=’Komornik’, rok_produkcji=2005, cena=10.5.
--Uwaga: polecenia DML nie pobierają danych. Jedną odpowiedzią jaką z reguły generują jest informacja
--dotycząca liczby przetworzonych krotek. Aby uzyskać poniższe wyniki potwierdzające poprawność wykonania
--poleceń DML należy wykonać stosowne polecenia SELECT po uprzednim wykonaniu polecenia DML.--

INSERT INTO filmy VALUES (11,'Komornik',2005,10.5); 
SELECT * FROM filmy;

--Polecenie zad 2--
--Z relacji FILMY usuń krotki opisujące filmy nakręcone w roku 2005.--

DELETE FROM filmy WHERE rok_produkcji=2005; 
SELECT * FROM filmy;

--Polecenie zad 3--
--Podnieś o 0,5 zł cenę wypożyczenia wszystkich filmów nakręconych przed rokiem 1980.--

UPDATE filmy SET cena=cena + 0.5 WHERE rok_produkcji<1980; 
SELECT * FROM filmy;

--Polecenie zad 4--
--Do relacji FILMY wstaw nową krotkę: id_filmu=12, tytul=’Nikofor’, rok_produkcji=2004, cena=9.5.--

INSERT INTO filmy VALUES(12,'Nikofor',2004, 9.5); 
SELECT * FROM filmy;

--Polecenie zad 5--
--Z relacji FILMY usuń wszystkie krotki opisujące filmy, w których nie zagrał żaden aktor.--

DELETE FROM filmy WHERE id_filmu <> ALL (SELECT id_filmu FROM obsada); 
SELECT * FROM filmy;

--Polecenie zad 6--
--Zmień cenę wypożyczenia filmu pt. ‘Taksowkarz’ na 5 zł.--

UPDATE filmy SET cena=5 WHERE tytul ='Taksowkarz'; 
SELECT * FROM filmy;