--Polecenie zad 1--
--Utwórz relację AKTORZY_OPERACJE(data DATE, oper VARCHAR(100)), która posłuży do śledzenia operacji wykonywanych przez użytkownika.

CREATE TABLE AKTORZY_OPERACJE(
data date, 
oper varchar(100));

--Polecenie zad 2--
--Utwórz wyzwalacz reagujący na operacje wprowadzania i usuwania krotek z relacji AKTORZY. Czas i rodzaj każdej operacji wykonywanej na relacji AKTORZY powinien być zapisywany w relacji AKTORZY_OPERACJE. Przetestuj działanie wyzwalacza. W rozwiązaniu zamieść wszystkie polecenie potrzebne do utworzenia wyzwalacza.

CREATE OR REPLACE FUNCTION wprowadzanie() RETURNS trigger AS $$
BEGIN 
 INSERT INTO AKTORZY_OPERACJE VALUES (now(),TG_OP);
 return new;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER wyzw BEFORE INSERT OR DELETE ON filmy 
FOR EACH ROW EXECUTE PROCEDURE wprowadzanie();

SELECT * FROM filmy
INSERT INTO filmy (tytul, rok_produkcji,cena) VALUES ('wesele',9999,99);
DELETE FROM filmy WHERE cena=99;
SELECT * FROM aktorzy_operacje;


--Polecenie zad 3--
--Usuń wyzwalacz i procedurę wyzwalacza.

DROP TRIGGER wyzw ON filmy;
DROP FUNCTION wprowadzanie;


--Na potrzeby zadań utwórz tablice pracownicy(id_pracownika, imie, nazwisko, miasto, pensja)--


--Polecenie zad 4--
--Utwórz w języku PL/pgSQL funkcję PIT(dochód REAL) służącą do wyliczania należnego podatku dochodowego od osób fizycznych według skali podatkowej. Obliczenia powinny odbywać się według następującego algorytmu:
-- jeżeli "dochód"<= 85528 zł, to podatek należny wynosi 18% z "dochód" minus 556,02 zł
-- jeżeli "dochód" > 85528 zł, to podatek należny wynosi 14839 zł plus 32% z ("dochód" - 85528 zł) 
--Następnie sprawdź działanie funkcji PIT() na tabeli pracownicy:
--select nazwisko, pensja, pit(pensja) from pracownicy;

CREATE OR REPLACE FUNCTION PIT(dochod real) RETURNS real AS $$
DECLARE
podatek real;
BEGIN
podatek=0;
IF dochod>85528 THEN
	podatek=(dochod-85528)*0.32 + 14839;
ELSEIF dochod=<85528 AND dochod>556.02 THEN
	podatek=dochod*0.18 - 556.02;
END IF;
RETURN podatek;
END;
$$ language PLPGSQL;
INSERT INTO pracownicy (imie,nazwisko,miasto,pensja) VALUES ('John','Smith','Warsaw',120000);
SELECT nazwisko,pensja,PIT(pensja) FROM pracownicy;


--Polecenie zad 5--
--Utwórz w języku PL/pgSQL funkcję HIRE(id_pracownika INT, imie VARCHAR, nazwisko VARCHAR, miasto VARCHAR, pensja REAL) służącą do wstawienia nowego rekordu do tabeli PRACOWNICY. Funkcja powinna zwracać wartość tekstową:
-- "OK", jeżeli wstawianie rekordu odbędzie się bez zgłoszenia wyjątku
-- "DUPLIKAT ID", jeżeli podczas próby wstawienia rekordu zostanie zgłoszony wyjątek UNIQUE_VIOLATION
--Następnie sprawdź działanie funkcji HIRE():
--select hire(6, 'Jan', 'Kowalski', 'Poznan', 100);
--select hire(5, 'Anna', 'Nowak', 'Poznan', 200); 

CREATE OR REPLACE HIRE(id_pracownika int, imie varchar, nazwisko varchar, miasto varchar, pensja real) RETURNS varchar AS $$
BEGIN
INSERT INTO pracownicy(id_pracownika,imie,nazwisko,miasto,pensja) 
VALUES(id_pracownika,imie,nazwisko,miasto,pensja);
RETURN 'OK';
EXCEPTION
	WHEN unique_violation THEN
		RETURN 'DUPLIKAT ID';
END;
$$ language PLPGSQL;

SELECT HIRE(6, 'Jan', 'Kowalski', 'Poznan', 100);  
SELECT HIRE(5, 'Anna', 'Nowak', 'Poznan', 200); 
SELECT * FROM pracownicy;


--Polecenie zad 6--
--Utwórz wyzwalacz DOUBLE_SALARY i związaną z nim procedurę wyzwalaną DOUBLE_SALARY_FUN, który każdemu nowo wstawianemu do tabeli PRACOWNICY rekordowi
--podwoi wartość kolumny PENSJA. Następnie sprawdź działanie wyzwalacza:
--INSERT INTO pracownicy VALUES(10, 'Jan', 'Kowalski', 'Poznan', 100);
--SELECT * FROM pracownicy WHERE id_pracownika=10;

CREATE OR REPLACE FUNCTION DOUBLE_SALARY_FUN() RETURNS trigger AS $$
DECLARE 
salary pracownicy.pensja%TYPE;
maxID int;
BEGIN
SELECT pensja INTO salary FROM pracownicy WHERE id_pracownika=(SELECT MAX(id_pracownika) FROM pracownicy);
SELECT MAX(id_pracownika) INTO maxID FROM pracownicy;
salary=salary*2;
UPDATE pracownicy
SET pensja=salary
WHERE id_pracownika=maxID;
RETURN new;
END;
$$ language PLPGSQL
CREATE trigger DOUBLE_SALARY AFTER INSERT ON pracownicy
EXECUTE PROCEDURE DOUBLE_SALARY_FUN();
INSERT INTO pracownicy VALUES(10, 'Jan', 'Kowalski', 'Poznan', 100);  
SELECT * FROM pracownicy WHERE id_pracownika=10;

