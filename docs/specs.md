
# Specyfikacja funkcjonalna
## Aplikacja Companion dla Politechniki Warszawskiej

> **📋 Uwaga dotycząca mock-upów i interfejsów użytkownika**: 
> - Mock-upy w `docs/mock/` dotyczą **wyłącznie aplikacji mobilnej Flutter dla studentów** (Android/iOS)
> - Panele administracyjne Django (dla jednostek i administratorów merytorycznych) są implementowane bezpośrednio w Django z użyciem Django Template Language (DTL), **bez warstwy API**
> - Szczegółowe informacje o brakujących mock-upach i wymaganiach dla paneli Django: [`docs/MOCKUPY.md`](MOCKUPY.md)

> **🧭 Nazewnictwo**: **Aplikacja Companion** to oficjalna nazwa projektu. **PW_hub** to robocza/deweloperska nazwa aplikacji powstającej w ramach projektu. Nazwa marketingowa produktu nie została jeszcze ustalona.

---

## 1. Informacje ogólne

### 1.1 Cel dokumentu
Celem niniejszej specyfikacji funkcjonalnej jest szczegółowe opisanie funkcjonalności aplikacji mobilnej *Companion dla Politechniki Warszawskiej*, w sposób umożliwiający jej jednoznaczną implementację, testowanie oraz ocenę w ramach projektu IPI.

### 1.2 Zakres systemu
System składa się z dwóch głównych interfejsów:
1. **Aplikacja mobilna Flutter** - narzędzie informacyjno-organizacyjne dla studentów wspierające życie studenckie
2. **Panele webowe Django** - interfejsy zarządzania dla jednostek organizacyjnych i administratorów merytorycznych

System nie zastępuje systemów dydaktycznych (USOS), a jedynie integruje i prezentuje kluczowe informacje.

### 1.3 Platformy
**Aplikacja mobilna (studenci):**
- Android
- iOS

**Panele webowe (jednostki i administratorzy):**
- Przeglądarka webowa (desktop)
- Django Template Language (DTL)
- Bez warstwy REST API - bezpośrednia komunikacja z bazą danych przez Django ORM

---

## 2. Role użytkowników

### 2.1 Student (aplikacja mobilna Flutter)
- przegląda aktualności i wydarzenia,
- zapisuje się na wydarzenia,
- otrzymuje powiadomienia,
- korzysta z map kampusu.

### 2.2 Organizator/Pracownik jednostki (panel webowy Django)
- tworzy i edytuje wydarzenia przypisane do jednostki,
- zarządza zapisami na wydarzenia,
- przegląda listę uczestników,
- publikuje aktualności jednostki,
- dostęp przez panel Django (DTL, bez API).

### 2.3 Administrator merytoryczny (panel webowy Django)
- zarządza użytkownikami i rolami,
- moderuje treści ze wszystkich jednostek,
- konfiguruje integracje,
- przegląda globalne statystyki,
- zarządza wszystkimi jednostkami organizacyjnymi,
- dostęp przez dedykowany panel Django (DTL, nie Django Admin, bez API).

> **💡 Uwaga**: Panel administratora merytorycznego NIE wykorzystuje standardowego Django Admin. Jest to dedykowany interfejs zbudowany przy użyciu Django views i templates, zaprojektowany specjalnie dla administratorów nietechnicznych z pełną zgodnością WCAG 2.1.

---

## 3. Funkcjonalności

## 3.1 Rejestracja i logowanie

### Opis
Użytkownik loguje się do aplikacji przy użyciu konta uczelnianego.

### Wymagania funkcjonalne
- logowanie SSO,
- automatyczne przypisanie roli,
- brak lokalnych haseł.

---

## 3.2 System aktualności

### Opis
Centralny strumień informacji publikowanych przez uczelnię i organizacje.

### Funkcje
- lista aktualności,
- filtrowanie po kategorii,
- oznaczanie jako przeczytane,
- wersje językowe.

---

## 3.3 Kalendarz wydarzeń

### Opis
Moduł prezentujący wydarzenia studenckie.

### Funkcje
- widok listy i kalendarza,
- wyszukiwanie wydarzeń,
- filtrowanie (kategoria, język, dostępność),
- szczegóły wydarzenia.

---

## 3.4 Szczegóły wydarzenia

### Zakres informacji
- tytuł i opis,
- data i godzina,
- lokalizacja,
- organizator,
- dostępność:
  - architektoniczna,
  - sensoryczna,
  - językowa.

---

## 3.5 Zapisy na wydarzenia

### Opis
Obsługa rejestracji uczestników.

### Funkcje
- zapisz / wypisz się,
- limit miejsc,
- lista uczestników (organizator),
- generowanie wejściówek QR.

---

## 3.6 Wejściówki

### Opis
Cyfrowa forma potwierdzenia zapisu na wydarzenie. Wejściówka zawiera unikalny kod QR umożliwiający weryfikację uczestnictwa przez organizatora.

### Funkcje
- **unikalny kod QR** - każda wejściówka posiada unikalny kod UUID, który jest zapisywany jako kod QR,
- **podgląd offline** - wejściówka może być pobrana do urządzenia mobilnego wraz z kodem QR w formacie base64,
- **weryfikacja przez organizatora** - organizator może zeskanować kod QR i zweryfikować ważność wejściówki.

### Szczegóły techniczne

#### Model danych
Wejściówka (Ticket) jest powiązana 1:1 z rejestracją (Registration):
- **Registration**: powiązanie uczestnika (User) z wydarzeniem (Event)
  - status rejestracji (confirmed/cancelled/waitlist)
  - dane uczestnika (imię, email, numer ID)
  - notatki dodatkowe
- **Ticket**: cyfrowa wejściówka
  - unikalny kod UUID (ticket_code)
  - kod QR (obraz PNG generowany automatycznie)
  - data wystawienia (issued_at)
  - data skanowania (scanned_at)
  - flaga ważności (is_valid)

#### Generowanie kodu QR
- Kod QR jest automatycznie generowany przy utworzeniu wejściówki (via Django signals)
- Koduje UUID wejściówki dla łatwej weryfikacji
- Zapisywany jako plik PNG w katalogu `tickets/qr_codes/`
- Używana biblioteka: `qrcode` (wersja 8.0)

#### API Endpoints

**Pobieranie wejściówek użytkownika:**
```
GET /api/tickets/
```
Zwraca listę wejściówek zalogowanego użytkownika z pełnymi metadanymi wydarzenia.

**Szczegóły wejściówki:**
```
GET /api/tickets/{id}/
```
Zwraca szczegóły wejściówki wraz z:
- tytułem wydarzenia
- datą i czasem wydarzenia
- lokalizacją
- danymi uczestnika
- URL do kodu QR
- kodem QR w base64 (dla podglądu offline)

**Pobieranie dla offline:**
```
GET /api/tickets/{id}/download/
```
Endpoint dedykowany do pobrania wejściówki z kodem QR w base64 dla użycia offline.

**Weryfikacja wejściówki (organizator):**
```
POST /api/tickets/verify/
Body: { "ticket_code": "uuid-string" }
```
Weryfikuje wejściówkę i oznacza ją jako zeskanowaną. Dostępne tylko dla:
- organizatora wydarzenia (created_by)
- użytkowników ze statusem staff

Walidacja:
- Sprawdza czy wejściówka istnieje
- Sprawdza czy użytkownik ma uprawnienia (organizer lub staff)
- Sprawdza czy wejściówka jest ważna (is_valid)
- Sprawdza czy nie została już wcześniej zeskanowana (scanned_at)
- Przy poprawnej weryfikacji - ustawia scanned_at na aktualny czas

Możliwe odpowiedzi:
- Sukces: `{"valid": true, "message": "...", "ticket": {...}, "scanned_at": "..."}`
- Błąd: `{"valid": false, "message": "..."}`

#### Uprawnienia
- Tylko właściciel rejestracji może przeglądać swoją wejściówkę
- Tylko organizator wydarzenia lub staff może weryfikować wejściówki
- Weryfikacja zapisuje timestamp skanowania i zapobiega wielokrotnemu użyciu

---

## 3.7 Mapy kampusu

### Opis
Nawigacja po kampusach PW.

### Funkcje
- mapa kampusu,
- wybór budynków,
- trasy piesze,
- trasy dostępne dla osób z ograniczeniami ruchowymi.

---

## 3.8 Integracja z USOS

### Opis
Prezentacja informacji akademickich.

### Funkcje
- pobieranie terminów,
- przypomnienia,
- tryb tylko do odczytu.

---

## 3.9 Powiadomienia

### Rodzaje
- przypomnienia o wydarzeniach,
- nowe aktualności,
- ważne terminy z USOS.

---

## 4. Wymagania niefunkcjonalne

### 4.1 Dostępność
- zgodność z WCAG 2.1,
- opisy alternatywne,
- wsparcie czytników ekranu.

### 4.2 Wydajność
- czas odpowiedzi < 2s,
- obsługa wielu użytkowników.

### 4.3 Bezpieczeństwo
- RODO,
- szyfrowanie transmisji,
- kontrola uprawnień.

---

## 5. Scenariusze użytkownika

### 5.1 Student zapisuje się na wydarzenie
1. Otwiera wydarzenie.
2. Sprawdza dostępność.
3. Kliknięcie „Zapisz się”.
4. Otrzymanie wejściówki.

### 5.2 Organizator publikuje wydarzenie
1. Dodaje wydarzenie.
2. Uzupełnia dostępność.
3. Publikuje wydarzenie.

---

## 6. Kryteria akceptacji
- wszystkie funkcje dostępne na Android i iOS,
- pozytywne testy dostępności,
- poprawne działanie integracji.

---

## 7. Uwagi końcowe
Specyfikacja stanowi podstawę do implementacji MVP oraz dalszego rozwoju aplikacji.
