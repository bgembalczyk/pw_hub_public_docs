# Aplikacja Companion dla Politechniki Warszawskiej
## Wymagania i koncepcja wdrożenia

> **📋 Uwaga dotycząca mock-upów**: Wszystkie mock-upy w katalogu `docs/mock/` dotyczą **wyłącznie aplikacji mobilnej Flutter dla studentów**. Dokumentacja dotycząca paneli administracyjnych Django oraz brakujących mock-upów znajduje się w [`docs/MOCKUPY.md`](MOCKUPY.md).

> **🧭 Nazewnictwo**: **Aplikacja Companion** to oficjalna nazwa projektu. **PW_hub** to robocza/deweloperska nazwa aplikacji powstającej w ramach projektu. Nazwa marketingowa produktu nie została jeszcze ustalona.

## 1. Wprowadzenie
Celem projektu jest stworzenie aplikacji mobilnej typu *companion* dla studentów Politechniki Warszawskiej, która integruje informacje o życiu studenckim, wydarzeniach, inicjatywach oraz kluczowych terminach akademickich w jednym, dostępnym i inkluzywnym narzędziu.

Projekt realizowany jest w ramach Indywidualnego Projektu Innowacyjnego (IPI) programu **Uczelnie Przyszłości**.

---

## 2. Cele projektu
- Ułatwienie adaptacji nowych studentów, studentów zagranicznych oraz osób z niepełnosprawnościami.
- Centralizacja informacji o wydarzeniach i inicjatywach studenckich.
- Zwiększenie zaangażowania studentów w życie uczelni.
- Podniesienie standardów dostępności informacji i wydarzeń.
- Uzupełnienie istniejących systemów akademickich (np. USOS), a nie ich zastępowanie.

---

## 3. Grupy docelowe
- Studenci Politechniki Warszawskiej.
- Nowi studenci i studenci zagraniczni.
- Studenci z niepełnosprawnościami.
- Samorząd Studentów i organizacje studenckie.
- Jednostki organizacyjne uczelni.

---

## 4. Zakres funkcjonalny (wymagania funkcjonalne)

### 4.1 System aktualności
- Publikowanie aktualności przez:
  - uczelnię,
  - samorząd,
  - organizacje studenckie.
- Filtrowanie wiadomości tematycznie.
- Obsługa wielu języków (PL/EN).

### 4.2 Kalendarz wydarzeń
- Tworzenie i edycja wydarzeń przez uprawnionych organizatorów.
- Widok listy oraz kalendarza.
- Kategorie wydarzeń (kultura, sport, nauka, integracja).
- Zapisy na wydarzenia.

### 4.3 Rejestracja i wejściówki
- Rejestracja użytkowników na wydarzenia.
- Limity miejsc.
- Generowanie cyfrowych wejściówek (QR).
- Lista uczestników dla organizatora.

### 4.4 Informacje o dostępności wydarzeń
Każde wydarzenie zawiera:
- język wydarzenia,
- dostępność architektoniczną,
- informacje o bodźcach sensorycznych (hałas, światła),
- lokalizację i czas trwania.

### 4.5 Mapy kampusu
- Mapy kampusów i budynków PW.
- Wyznaczanie tras pieszych.
- Trasy uwzględniające ograniczenia ruchowe.

### 4.6 Integracja z USOS
- Przypomnienia o:
  - zapisach na zajęcia,
  - egzaminach,
  - płatnościach,
  - ważnych terminach administracyjnych.
- Synchronizacja tylko w trybie informacyjnym.

---

## 5. Wymagania niefunkcjonalne

### 5.1 Dostępność
- Zgodność z WCAG 2.1.
- Czytelne kontrasty.
- Obsługa czytników ekranu.
- Prosty i przewidywalny interfejs.

### 5.2 Bezpieczeństwo
- Logowanie z wykorzystaniem kont uczelnianych.
- Bezpieczna integracja z API USOS.
- Ochrona danych osobowych (RODO).

### 5.3 Skalowalność
- Możliwość wdrożenia na innych uczelniach.
- Modularna architektura backendu.

---

## 6. Koncepcja techniczna

### 6.1 Architektura
- **Frontend mobilny**: Flutter (Android + iOS) - dla studentów.
- **Frontend webowy**: Django Template Language (DTL) - panel dla jednostek i administratorów merytorycznych.
- **Backend**: Django + Django REST Framework.
- **Baza danych**: PostgreSQL.
- **Autoryzacja**: OAuth2 / SSO uczelni.
- **Mapy**: dane wektorowe + OpenStreetMap / mapy PW.

> **📱 Frontend mobilny (Flutter)**: 
> - Mock-upy znajdują się w `docs/mock/` (format HTML)
> - Komunikacja z backendem przez REST API (Django REST Framework)
> - Przeznaczony dla studentów
> 
> **🖥️ Frontend webowy (Django DTL)**: 
> - Mock-upy w `docs/mock_django/` (format PlantUML salt)
> - Bezpośrednia komunikacja z bazą danych przez Django ORM (bez API)
> - Dwa panele: panel jednostek oraz panel administratora merytorycznego (nie Django Admin)
> - Więcej informacji: [`docs/MOCKUPY.md`](MOCKUPY.md)

### 6.2 Model danych (wysoki poziom)
- Użytkownik
- Wydarzenie
- Organizator
- Aktualność
- Lokalizacja
- Wejściówka / rejestracja

### 6.3 Integracje
- USOS API.
- Systemy mapowe PW.
- Powiadomienia push.

---

## 7. Harmonogram (wysoki poziom)
1. Analiza wymagań i konsultacje dostępności.
2. Projekt UX/UI.
3. Implementacja backendu.
4. Implementacja aplikacji mobilnej.
5. Integracje zewnętrzne.
6. Testy użytkowe.
7. Pilotaż na PW.

---

## 8. Kamienie milowe
- Specyfikacja funkcjonalna.
- Prototyp aplikacji.
- Działające MVP.
- Testy z użytkownikami.
- Wersja pilotażowa.

---

## 9. Wymagane zasoby
- Dostęp do infrastruktury serwerowej.
- Dostęp do map kampusu.
- Dostęp do API USOS.
- Konsultacje ds. dostępności.
- Wsparcie UX/UI.
- Szkolenia Flutter.

---

## 10. Potencjał rozwoju
- Wdrożenie na innych uczelniach.
- Rozszerzenie o moduły informacyjne.
- Integracje z kolejnymi systemami akademickimi.

---

## 11. Podsumowanie
Aplikacja Companion dla PW odpowiada na realne potrzeby studentów, wprowadza nowy standard dostępności i ma potencjał skalowania na poziomie krajowym. Projekt jest innowacyjny organizacyjnie i społecznie, a jego wdrożenie może znacząco poprawić jakość życia studenckiego.
