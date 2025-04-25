# Baza danych wypożyczalni filmów - Przykładowe rozwiązania zadań

## Spis treści
1. [Tworzenie bazy danych](#tworzenie-bazy-danych)
2. [Opis działów](#opis-działów)
3. [Autor](#autor)

---

## Tworzenie bazy danych

W pliku init.sql znajdują sie komendy, które umożliwiają utworzenie struktury bazy danych oraz jej inicjalizację danymi. W przypadku, gdy tabele już istnieją, zostaną najpierw usunięte.

Zaleca się uruchomienie osobnego pliku `init.sql`, który zawiera pełną konfigurację bazy:

```bash
psql -U postgres -d twoja_baza -f init.sql
```

Plik `init.sql` znajduje się w repozytorium i zawiera pełny kod tworzący strukturę bazy i dane testowe.

---

## Opis działów

Każdy z działów poniżej zawiera praktyczne zapytania SQL i przykłady zastosowania dla konkretnego tematu. Kliknij nazwę pliku, aby przejść bezpośrednio do jego zawartości w repozytorium.

### 1. [Selekcja i projekcja](./1.%20Selekcja%20i%20projekcja.sql)
Zadania dotyczą podstawowych operacji SELECT, filtrowania danych za pomocą WHERE oraz wyboru konkretnych kolumn (projekcji).

### 2. [Połączenia](./2.%20Po%C5%82%C4%85czenia.sql)
Zagadnienia dotyczące łączenia danych z wielu tabel przy użyciu JOIN: natural join, join on, cross join.

### 3. [Operacje mnogościowe](./3.%20Operacje%20mnogo%C5%9Bciowe.sql)
Zadania z zakresu operacji na zbiorach: UNION, INTERSECT, EXCEPT.

### 4. [Funkcje grupowe](./4.%20Funkcje%20grupowe.sql)
Zastosowanie funkcji agregujących takich jak COUNT, AVG, SUM, MIN, MAX oraz klauzuli GROUP BY i HAVING.

### 5. [Podzapytania](./5.%20Podzapytania.sql)
Zadania z wykorzystaniem podzapytań w SELECT, WHERE oraz FROM. Zarówno zwykłe, jak i skorelowane.

### 6. [DML](./6.%20DML.sql)
Instrukcje INSERT, UPDATE i DELETE. Operacje modyfikujące dane w bazie.

### 7. [DDL](./7.%20DDL.sql)
Tworzenie, modyfikacja i usuwanie struktur danych: CREATE, ALTER, DROP.

### 8. [Perspektywy](./8.%20Perspektywy.sql)
Tworzenie widoków (VIEW) i ich zastosowanie w zapytaniach.

### 9. [Transakcje](./9.%20Transakcje.sql)
Użycie COMMIT, ROLLBACK, SAVEPOINT do kontrolowania spójności danych.

### 10. [Indeksy](./10.%20Indeksy.sql)
Tworzenie i użycie indeksów w celu optymalizacji zapytań.

### 11. [PLPGSQL](./11.%20PLPGSQL.sql)
Podstawy programowania w PostgreSQL: funkcje, zmienne, sterowanie przepływem.

### 12. [Wyzwalacze](./12.%20Wyzwalacze.sql)
Tworzenie TRIGGERÓW reagujących na zdarzenia INSERT, UPDATE, DELETE.

## Autor
Autorem zadań jest: **dr hab. Maciej Zakrzewicz**.

Niniejszy projekt zawiera moje przykładowe rozwiązania zadań, zrealizowane w ramach nauki systemów baz danych.


