--Polecenie zad 1--
--Utwórz relację PIASEK (ID_ZIARENKA SERIAL, MASA_ZIARENKA REAL, KOLOR_ZIARENKA VARCHAR(10)). Wprowadź cztery dowolne krotki do relacji PIASEK. Np.:
--id_ziarenka | masa_ziarenka | kolor_ziarenka
--------------+---------------+----------------
--     1      |     0.025     |     szary
--     2      |     0.021     |     czarny
--     3      |     0.018     |     bialy
--     4      |     0.031     |     czarny

CREATE TABLE PIASEK (
ID_ZIARENKA serial, 
MASA_ZIARENKA real,
KOLOR_ZIARENKA varchar(10)
);
INSERT INTO PIASEK (MASA_ZIARENKA, KOLOR_ZIARENKA)
VALUES (0.025, 'szary'), (0.021, 'czarny'), (0.018, 'bialy'), (0.031, 'czarny')

--Polecenie zad 2--
--. Korzystając z polecenia INSERT INTO SELECT powielaj krotki relacji PIASEK tyle razy, aby posiadała ponad milion krotek.
--Uwaga: nie zamazuj wartości automatycznie wypełnianego atrybutu ID_ZIARENKA.

INSERT INTO PIASEK (MASA_ZIARENKA, KOLOR_ZIARENKA)
SELECT MASA_ZIARENKA, KOLOR_ZIARENKA FROM PIASEK;

--Polecenie zad 3--
--. Dokonaj pomiaru czasu wykonania zapytania wyświetlającego kolor ziarenka piasku o identyfikatorze 123456.

SELECT KOLOR_ZIARENKA FROM PIASEK WHERE ID_ZIARENKA= 123456;

--Polecenie zad 4--
--Dokonaj pomiaru czasu wykonania zapytania wyświetlającego liczbę ziarenek piasku o identyfikatorach pomiędzy 500000 a 500005.

SELECT COUNT(ID_ZIARENKA) FROM PIASEK WHERE ID_ZIARENKA > 500000 AND ID_ZIARENKA < 500005;

--Polecenie zad 5--
--. Dokonaj pomiaru czasu wykonania zapytania wyświetlającego liczbę ziarenek piasku o masie 0.025 g.

SELECT COUNT(ID_ZIARENKA) FROM PIASEK WHERE MASA_ZIARENKA BETWEEN 0.0249 AND 0.0251;


--Polecenie zad 6--
--Utwórz indeks B*-drzewo o nazwie PIASEK_IND oparty na atrybucie ID_ZIARENKA relacji PIASEK.

CREATE INDEX PIASEK_IND ON PIASEK(ID_ZIARENKA);

--Polecenie zad 7--
--Ponownie dokonaj pomiaru czasu wykonania zapytania wyświetlającego kolor ziarenka piasku o identyfikatorze 123456. Czy czas ten uległ zmianie? Dlaczego?

-- czas uległ zmianie, ponieważ jest indeksowana tabela

--Polecenie zad 8--
--Dokonaj pomiaru czasu wykonania zapytania wyświetlającego liczbę ziarenek piasku o identyfikatorach pomiędzy 500000 a 500005. Czy czas ten uległ zmianie? Dlaczego?

-- czas uległ zmianie, ponieważ jest indeksowana tabela

--Polecenie zad 9--
--Dokonaj pomiaru czasu wykonania zapytania wyświetlającego liczbę ziarenek piasku o masie 0.025 g. Czy czas ten uległ zmianie? Dlaczego?

-- czas nie uległ zmianie, ponieważ indeks dotyczy ID_ZIARENKA a nie masy piasku.

--Polecenie zad 10--
-- Usuń indeks B*-drzewo o nazwie PIASEK_IND

DROP INDEX PIASEK_IND;