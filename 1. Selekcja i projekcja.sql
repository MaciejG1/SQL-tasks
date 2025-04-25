--Polecenie zad 1--
--Wyświetl tytuły filmów wyprodukowanych w roku 1998 lub w roku 1999.--

SELECT * FROM filmy WHERE rok_produkcji BETWEEN 1998 and 1999;

--Polecenie zad 2--
--Wyświetl tytuły i ceny wypożyczenia filmów, których cena wypożyczenia przekracza 9 zł. Wynik uporządkuj rosnąco według ceny wypożyczenia.--

SELECT * FROM filmy WHERE cena > 9 ORDER BY cena DESC;

--Polecenie zad 3--
--Wyświetl nazwiska wszystkich klientów o imieniu ‘Jan’.--

SELECT nazwisko FROM klienci WHERE imie='Jan';

--Polecenie zad 4--
--Wyświetl imiona i nazwiska wszystkich klientów, których imię liczy więcej znaków niż nazwisko.--

SELECT imie,nazwisko FROM klienci WHERE LENGTH(nazwisko)<LENGTH(imie);

--Polecenie zad 5--
--Wyświetl nazwiska wszystkich aktorów o imionach: ‘Arnold’, ’Tom’ i ‘Jodie’. Wynik uporządkuj malejąco według nazwisk.--

SELECT nazwisko FROM aktorzy WHERE imie='Arnold' OR imie='Tom' OR imie='Jodie' ORDER BY nazwisko ASC;

--Polecenie zad 6--
--Wyświetl identyfikatory wszystkich filmów, których kopie są aktualnie dostępne w wypożyczalni. Wyeliminuj duplikaty. Wynik uporządkuj rosnąco w kolejności identyfikatorów filmów.--

SELECT DISTINCT id_filmu FROM kopie WHERE czy_dostepna='T' ORDER BY id_filmu;

--Polecenie zad 7--
--Wyświetl identyfikatory wszystkich kopii, które zostały wypożyczone pomiędzy ‘2005-07-15’ a ‘2005-07-22’. Wyeliminuj duplikaty. Wynik uporządkuj rosnąco w kolejności identyfikatorów kopii.--

SELECT id_kopii FROM wypozyczenia WHERE data_wypozyczenia BETWEEN '2005-07-15' AND '2005-07-22' ORDER BY id_kopii ASC;

--Polecenie zad 8--
--Wyświetl identyfikatory i czas trwania wypożyczenia (w dniach) wszystkich kopii, które zostały wypożyczone na okres dłuższy niż 1 dzień.--

SELECT id_kopii,(data_zwrotu - data_wypozyczenia) AS czas FROM wypozyczenia WHERE (data_zwrotu - data_wypozyczenia) > 1;

--Polecenie zad 9--
--Wyświetl dane wszystkich aktorów według następującego formatu: pierwsza litera imienia, kropka, spacja, nazwisko.--

SELECT CONCAT(LEFT(imie,1), '.', nazwisko) AS aktor FROM aktorzy;

--Polecenie zad 10--
--Wyświetl tytuły wszystkich filmów uporządkowane w kolejności od najkrótszego do najdłuższego tytułu.--

SELECT tytul FROM filmy ORDER BY LENGTH(tytul);

--Polecenie zad 11--
--Wyświetl tytuły i ceny wypożyczenia trzech najnowszych filmów.--

SELECT tytul,cena FROM filmy ORDER BY rok_produkcji DESC LIMIT 3;

--Polecenie zad 12--
--Dla każdego klienta wyświetl: pełne imię, pierwszą literę imienia, ostatnią literę imienia. Nagłówki kolumn powinny posiadać takie brzmienie, jak podano poniżej.--

SELECT imie,(LEFT(imie,1)) AS pierwsza,(RIGHT(imie,1)) AS ostatnia FROM klienci;

--Polecenie zad 13--
--Wyświetl te imiona klientów, których pierwsza i ostatnia litera imienia są identyczne. Ignoruj wielkość porównywanych znaków. Wyeliminuj duplikaty.--

SELECT DISTINCT imie FROM klienci WHERE (LEFT(UPPER(imie),1)) = (RIGHT(UPPER(imie),1));

--Polecenie zad 14--
--Wyświetl tytuły filmów, których przedostatnia litera tytułu to ‘o’--

SELECT tytul FROM filmy WHERE SUBSTRING(tytul,(LENGTH(tytul) - 1),1) = 'o';

--Polecenie zad 15--
--Dla każdego klienta wyświetl jego adres e-mail skonstruowany w następujący sposób: imię małymi literami, kropka, nazwisko małymi literami, ‘@wsb.pl’.--

SELECT CONCAT(LOWER(imie),'.',LOWER(nazwisko),'@wsb.pl') AS email FROM klienci; 