--Polecenie zad 1--
--Dla każdego roku produkcji filmu wyświetl średnią cenę wypożyczenia.--

SELECT rok_produkcji, AVG(cena) FROM filmy GROUP BY rok_produkcji ORDER BY rok_produkcji DESC;

--Polecenie zad 2--
--Wyświetl cenę najdroższego filmu w wypożyczalni.--

SELECT MAX(cena) FROM filmy;

--Polecenie zad 3--
--Wyświetl liczbę filmów wyprodukowanych w roku 1984.--

SELECT COUNT(rok_produkcji) FROM filmy GROUP BY rok_produkcji HAVING rok_produkcji=1984;

--Polecenie zad 4--
--Ile razy wypożyczono film pt. ‘Taksowkarz?.--

SELECT count(tytul) FROM filmy NATURAL JOIN kopie NATURAL JOIN wypozyczenia GROUP BY tytul HAVING tytul='Taksowkarz';

--Polecenie zad 5--
--Jaki był średni czas trwania wypożyczenia filmu pt. ‘Ronin’? Wynik wyświetl z dokładnością do jednego miejsca po przecinku.--

SELECT round(avg(data_zwrotu-data_wypozyczenia),1) FROM wypozyczenia NATURAL JOIN kopie NATURAL JOIN filmy WHERE tytul='Ronin';

--Polecenie zad 6--
--Wyświetl zestawienie tytułów wszystkich filmów wraz z minimalnymi, maksymalnymi i średnimi czasami trwania ich wypożyczenia oraz z liczbą dokonanych wypożyczeń. Wyniki liczbowe podaj z dokładnością do jednego miejsca po przecinku. Nagłówki wyświetlanych kolumn powinny być zgodne z podanym przykładem.--

SELECT tytul, ROUND(MIN(data_zwrotu-Data_wypozyczenia),1), ROUND(MAX(data_zwrotu-Data_wypozyczenia),1), ROUND(AVG(data_zwrotu-Data_wypozyczenia),1) AS sre, COUNT(tytul) AS razy FROM filmy NATURAL JOIN kopie NATURAL JOIN wypozyczenia GROUP BY tytul;

--Polecenie zad 7--
--Dla każdego klienta wypożyczalni wyświetl jego imię, nazwisko oraz liczbę dokonanych wypożyczeń.--

SELECT imie, nazwisko, COUNT(wypozyczenia.id_klienta) FROM klienci NATURAL JOIN wypozyczenia GROUP BY nazwisko, imie;

--Polecenie zad 8--
--Dla każdego aktora wyświetl liczbę filmów, w których zagrał. Pomiń aktorów, którzy zagrali tylko w jednym filmie.--

SELECT nazwisko, COUNT(id_filmu) FROM aktorzy NATURAL JOIN obsada GROUP BY nazwisko HAVING COUNT(id_filmu)>1;

--Polecenie zad 9--
--Dla każdego klienta wyświetl sumaryczną kwotę, jaką wydał na wypożyczanie filmów.--

SELECT nazwisko, SUM(cena) FROM klienci NATURAL JOIN wypozyczenia NATURAL JOIN kopie NATURAL JOIN filmy GROUP BY nazwisko;
