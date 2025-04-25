--Polecenie zad 1--
--Utwórz funkcję o nazwie CENA_BRUTTO(c REAL), która dla podanej ceny netto wyliczy odpowiadającą jej cenę brutto, powiększoną o 23%. Następnie wykonaj zapytanie, które na podstawie relacji FILMY wyświetli: tytuł filmu, cenę (netto) i cenę brutto.--

CREATE OR REPLACE FUNCTION CENA_BRUTTO(c real)  RETURNS real AS $$
BEGIN
	c = c*1.23;
	RETURN c;
END;
$$ LANGUAGE PLPGSQL;

SELECT tytul, cena AS netto,CENA_BRUTTO(cena) AS brutto FROM filmy;


--Polecenie zad 2--
--Utwórz funkcję o nazwie OPIS_FILMU(id INTEGER), która dla podanego identyfikatora filmu wyświetli jego opis zgodnie z poniższym wzorcem:
--SELECT OPIS_FILMU(2);
--Film “Ghostbusters” zostal nakrecony w roku 1984 przy udziale aktorow: Bill Murray, Dan Aykroyd, Sigourney Weaver.

CREATE OR REPLACE FUNCTION OPIS_FILMU(id INTEGER) RETURNS varchar AS $$
DECLARE 
	aktorzy_kursor CURSOR FOR SELECT imie,nazwisko FROM aktorzy NATURAL JOIN obsada WHERE ID_FILMU=id;
	imie_identyfikator aktorzy.imie%TYPE;
	nazwisko_identyfikator aktorzy.nazwisko%TYPE;
	wynik varchar(1000);
	tytul_identyfikator filmy.tytul%TYPE;
	rok filmy.rok_produkcji%TYPE;
BEGIN
	wynik:= '';

	SELECT tytul INTO tytul_identyfikator FROM filmy WHERE id_filmu=id;
	SELECT rok_produkcji INTO rok FROM filmy WHERE id_filmu=id;
	wynik= 'Film "' || tytul_identyfikator || '" zostal nakrecony w roku ' || rok || 'przy udziale aktorow: ';
	OPEN aktorzy_kursor;
	LOOP 
		FETCH aktorzy_kursor INTO imie_identyfikator, nazwisko_identyfikator;
		EXIT WHEN NOT FOUND;
		wynik := wynik || imie_identyfikator || ' ' || nazwisko_identyfikator || ', ';
	END LOOP;
	CLOSE aktorzy_kursor;
	RETURN wynik;
END;
$$ LANGUAGE plpgsql;

SELECT OPIS_FILMU(2);

--Polecenie zad 3--
--Dla atrybutu ID_FILMU relacji FILMY zdefiniuj ograniczenie integralnościowe typu UNIQUE, dbające o niepowtarzalność identyfikatorów filmów w obrębie relacji.--

alter table filmy
add unique(id_filmu)

--Polecenie zad 4--
-- Utwórz funkcję o nazwie DODAJ_FILM(id INTEGER, tyt VARCHAR, rok INTEGER, c REAL), służącą do wprowadzania nowej krotki do relacji FILMY. W przypadku, gdy podczas wykonania funkcji wystąpi wyjątek naruszenia ograniczenia integralnościowego UNIQUE, automatycznie zmodyfikuj wartość identyfikatora nowego filmu tak, aby była niepowtarzalna (np. aktualna wartość maksymalna + 1). Przetestuj działanie funkcji.

CREATE OR REPLACE FUNCTION DODAJ_FILM(id INTEGER,tyt VARCHAR, rok INTEGER, c REAL) RETURNS VOID AS $$
DECLARE
id_temp filmy.id_filmu%TYPE;
BEGIN
	SELECT MAX(id_filmu) INTO id_temp FROM filmy;
	id_temp= id_temp + 1;
	INSERT INTO filmy VALUES (id, tyt, rok, c );
EXCEPTION
	WHEN unique_violation THEN 
		INSERT INTO filmy VALUES (id_temp, tyt, rok, c );
END;
$$ LANGUAGE PLPGSQL;
SELECT dodaj_film(100,'berserker',1999,10);
SELECT * from filmy;
DELETE FROM filmy WHERE tytul='berserker';

--Polecenie zad 5--
--Usuń funkcję DODAJ_FILM--

DROP FUNCTION dodaj_film;

