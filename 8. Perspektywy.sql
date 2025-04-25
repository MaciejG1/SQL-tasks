-- Polecenie zad 1--
-- Utwórz perspektywę o nazwie STATYSTYKA_KLIENTOW, która będzie przedstawiać imię, nazwisko klienta oraz liczbę dokonanych przez niego wypożyczeń.--

create view STATYSTYKA_KLIENTOW as
select imie, nazwisko, count(data_wypozyczenia) as l_wyp from wypozyczenia natural join klienci group by imie,nazwisko;
select * from STATYSTYKA_KLIENTOW;

-- Polecenie zad 2--
--Korzystając z perspektyw STATYSTYKA_KLIENTOW, wyświetl imiona i nazwiska klientów, którzy wykonali dotąd ponad 2 wypożyczenia.--

select * from STATYSTYKA_KLIENTOW where l_wyp > 2

-- Polecenie zad 3--
--Usuń perspektywę STATYSTYKA_KLIENTOW. Sprawdź, czy zawartość relacji KLIENCI lub WYPOZYCZENIA uległa zmianie. Dlaczego?

Drop view STATYSTYKA_KLIENTOW;
select * from klienci; 
-- nic nie ubyło z tabeli ze wzgledu na wirtualny charakter VIEW (analogia do aliasów)
