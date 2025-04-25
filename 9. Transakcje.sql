--Polecenie zad 1--
--Rozpocznij nową transakcję, usuń wszystkie krotki z relacji FILMY, a następnie wycofaj bieżącą transakcję Sprawdź zawartość relacji FILMY.--

BEGIN; 
DELETE FROM filmy;
SELECT * FROM filmy;
ROLLBACK;

--Polecenie zad 2--
--Wykonaj następujące kroki:
--Rozpocznij nową transakcję,
--Do relacji FILMY wprowadź nową krotkę: ID_FILMU=11, TYTUL='KOMORNIK', ROK_PRODUKCJI=2005, CENA=10.5,
--Utwórz punkt zachowania o nazwie P1,
--usuń wszystkie krotki z relacji FILMY,
--Utwórz punkt zachowania o nazwie P2,
--usuń wszystkie krotki z relacji KOPIE,
--Wyświetl zawartość relacji FILMY i relacji KOPIE,
--Wycofaj transakcje do punktu zachowania P2,
--Wyświetl zawartość relacji FILMY i relacji KOPIE,
--Wycofaj transakcje do punktu zachowania P1,
--Wyświetl zawartość relacji FILMY i relacji KOPIE,
--Wycofaj transakcje,
--Wyświetl zawartość relacji FILMY i relacji KOPIE

BEGIN
INSERT INTO filmy VALUES (id_filmu=11, tytul='Komornik', rok_produkcji=2005,cena=10.5);
SAVEPOINT P1;
DELETE FROM filmy;
SAVEPOINT P2;
DELETE FROM kopie;
SELECT * FROM filmy;
SELECT * FROM kopie;
ROLLBACK P2;
SELECT * FROM filmy;
SELECT * FROM kopie;
ROLLBACK P1;
SELECT * FROM filmy;
SELECT * FROM kopie;
ROLLBACK;
SELECT * FROM filmy;
SELECT * FROM kopie;


--Polecenie zad 3--
--Podłącz się d bazy równocześnie z dwóch okien aplikacji. Wykonaj następujące kroki:
-- W pierwszym oknie rozpocznij nową transakcje,
-- W pierwszym oknie do relacji FILMY wprowadź nową krotkę: ID_FILMU=11, TYTUL='KOMORNIK', ROK_PRODUKCJI=2005, CENA=10.5,
-- W pierwszym oknie wyświetl zawartość relacji FILMY,
-- W drugim oknie wyświetl zawartość relacji FILMY. Czy zauważasz różnice?
-- W pierwszym oknie zatwierdź transakcje,
-- W pierwszym oknie wyświetl zawartość relacji FILMY,
-- W drugim oknie wyświetl zawartość relacji FILMY. Czy zauważasz różnice?

BEGIN;
INSERT INTO filmy VALUES (11,'Komornik',2005,10.5);
SELECT * FROM filmy;
COMMIT;
-- w drugim oknie wprowadzona zmiana jest widoczna dopiero po zatwierdzeniu zmian w pierwszym oknie(wywoalnie funkcji COMMIT)

--Polecenie zad 4--
--Podłącz się d bazy równocześnie z dwóch okien aplikacji. Wykonaj następujące kroki:
-- W pierwszym oknie rozpocznij nową transakcje,
-- W drugim oknie rozpocznij nową transakcje,
-- W pierwszym oknie zmień cenę filmu pt. 'Wesele' na 15zł,
-- W drugim oknie zmień rok produkcji filmu pt. 'Ronin' na 2000,
-- W pierwszym oknie zmień cenę filmu pt. 'Ronin' na 15zł,
-- W drugim oknie zmień rok produkcji filmu pt. 'Wesele' na 2000. Co się stało? Dlaczego?

BEGIN;
UPDATE filmy SET cena=15 WHERE tytul='Wesele';
UPDATE filmy SET cena=15 WHERE tytul='Ronin';
COMMIT
--wyskakuje blad od sharelock ktory jest spowodowany zakleszczeniem transakcji
--(czekaja za soba nawzajem aby wprowadzic zmiany na tych samych danych)

