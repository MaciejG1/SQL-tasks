--Polecenie zad 1--
--Wyświetl tytuł filmu, którego wypożyczenie kosztuje najwięcej. Nie korzystaj z operatora LIMIT.--

SELECT tytul FROM filmy WHERE cena = (SELECT MAX(cena) FROM filmy);

--Polecenie zad 2--
--Wyświetl nazwisko klienta, który dokonał pierwszego wypożyczenia w historii wypożyczalni. Nie korzystaj z operatora LIMIT.--

SELECT nazwisko FROM klienci NATURAL JOIN wypozyczenia WHERE data_wypozyczenia = (SELECT MIN(data_wypozyczenia) FROM wypozyczenia);

--Polecenie zad 3--
--Wyświetl tytuły filmów, których kopie są dostępne w wypożyczalni (czy_dostepna=’T’). Nie korzystaj z operacji połączenia.--

SELECT tytul FROM filmy WHERE id_filmu IN (SELECT id_filmu FROM kopie WHERE czy_dostepna='T');

--Polecenie zad 4--
--Wyświetl tytuły filmów, których wypożyczenie kosztuje więcej niż wypożyczenie filmu o tytule ‘Frantic’.--

SELECT tytul FROM filmy WHERE cena > (SELECT cena FROM filmy WHERE tytul='Frantic');

--Polecenie zad 5--
--Wyświetl tytuły filmów, których wypożyczenie kosztuje więcej niż wypożyczenie każdego filmu o tytule liczącym 6 liter.--

SELECT tytul FROM filmy WHERE cena > ALL (SELECT cena FROM filmy WHERE LENGTH(tytul)=6);
