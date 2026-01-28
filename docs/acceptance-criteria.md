# Kryteria akceptacji dla kluczowych flow użytkownika (MVP)

## Cel i źródła
Dokument definiuje jednoznaczne, testowalne kryteria akceptacji (AC) dla kluczowych flow aplikacji mobilnej (student). AC są powiązane z:
- specyfikacją funkcjonalną `docs/specs.md`,
- mock-upami aplikacji Flutter w `docs/mock/` opisanymi w `docs/MOCKUPY.md`.

## Role i walidacja jakościowa
- **QA Witcher (agent główny):** wszystkie AC są testowalne i mierzalne (pass/fail), bez sformułowań nieprecyzyjnych.
- **Product Questmaster (wspierająco):** AC są zgodne ze specyfikacją i nie rozszerzają scope poza opisane funkcje.

---

## 1) Zidentyfikowane kluczowe flow (początek i koniec)

### F1. Pierwsze logowanie / rejestracja przez SSO
- **Początek:** użytkownik uruchamia aplikację i nie jest uwierzytelniony.
- **Koniec:** użytkownik jest zalogowany i przypisana została rola.
- **Źródła:** `docs/specs.md` (sekcja 3.1), brak dedykowanych mock-upów logowania.

### F2. Logowanie użytkownika (SSO)
- **Początek:** użytkownik uruchamia aplikację i jest wylogowany.
- **Koniec:** aplikacja pokazuje ekran główny po udanym uwierzytelnieniu.
- **Źródła:** `docs/specs.md` (sekcja 3.1), brak dedykowanych mock-upów logowania.

### F3. Przeglądanie aktualności
- **Początek:** użytkownik wchodzi na listę aktualności.
- **Koniec:** użytkownik widzi listę aktualności i może ją filtrować.
- **Źródła:** `docs/specs.md` (sekcja 3.2), mock-up `docs/mock/news.html`.

### F4. Przeglądanie wydarzeń i szczegółów wydarzenia
- **Początek:** użytkownik otwiera listę wydarzeń.
- **Koniec:** użytkownik widzi szczegóły wybranego wydarzenia.
- **Źródła:** `docs/specs.md` (sekcje 3.3–3.4), mock-upy `docs/mock/events.html`, `docs/mock/event-details.html`.

### F5. Zapis na wydarzenie i podgląd wejściówki
- **Początek:** użytkownik jest na szczegółach wydarzenia.
- **Koniec:** użytkownik otrzymuje wejściówkę z kodem QR.
- **Źródła:** `docs/specs.md` (sekcje 3.5–3.6), mock-up `docs/mock/event-ticket.html`.

### F6. Przeglądanie poradników
- **Początek:** użytkownik wchodzi na listę poradników.
- **Koniec:** użytkownik widzi listę poradników.
- **Źródła:** `docs/specs.md` (rola studenta), mock-up `docs/mock/guides.html`.

---

## 2) Jawne założenia (niejednoznaczności)
1. **Brak mock-upów logowania/SSO:** zakładamy, że logowanie odbywa się w standardowym ekranie SSO (np. webview) i po sukcesie aplikacja wraca na ekran główny. AC nie opisują wyglądu UI logowania.
2. **Brak mock-upu rejestracji:** zakładamy, że pierwsze logowanie przez SSO jest równoznaczne z utworzeniem konta i automatycznym przypisaniem roli.
3. **Brak szczegółowego mock-upu listy poradników:** zakładamy, że ekran zawiera listę pozycji z możliwością przewijania, zgodnie z `docs/mock/guides.html`.

---

## 3) Kryteria akceptacji (Given / When / Then)

### F1. Pierwsze logowanie / rejestracja przez SSO
- **AC-F1-1**
  - **Given** użytkownik uruchamia aplikację i nie ma aktywnej sesji,
  - **When** wybiera opcję logowania przez SSO i poprawnie uwierzytelnia się w SSO,
  - **Then** aplikacja tworzy konto użytkownika i przypisuje rolę automatycznie, a użytkownik widzi ekran główny.
- **AC-F1-2**
  - **Given** użytkownik uruchamia aplikację i nie ma aktywnej sesji,
  - **When** logowanie w SSO kończy się niepowodzeniem,
  - **Then** użytkownik pozostaje niezalogowany i widzi komunikat o niepowodzeniu logowania (bez utworzenia konta).

### F2. Logowanie użytkownika (SSO)
- **AC-F2-1**
  - **Given** użytkownik jest wylogowany,
  - **When** poprawnie uwierzytelnia się przez SSO,
  - **Then** aplikacja otwiera ekran główny (np. `home.html`).
- **AC-F2-2**
  - **Given** użytkownik jest zalogowany,
  - **When** ponownie uruchamia aplikację,
  - **Then** widzi ekran główny bez ponownego logowania.

### F3. Przeglądanie aktualności
- **AC-F3-1**
  - **Given** użytkownik jest zalogowany,
  - **When** otwiera ekran aktualności (`news.html`),
  - **Then** widzi listę aktualności posortowaną zgodnie z UI listy.
- **AC-F3-2**
  - **Given** użytkownik jest na ekranie aktualności,
  - **When** wybiera filtr kategorii,
  - **Then** lista aktualności pokazuje tylko pozycje z wybranej kategorii.
- **AC-F3-3**
  - **Given** użytkownik widzi listę aktualności,
  - **When** oznacza aktualność jako przeczytaną,
  - **Then** aktualność zmienia stan na „przeczytana” w liście.

### F4. Przeglądanie wydarzeń i szczegółów wydarzenia
- **AC-F4-1**
  - **Given** użytkownik jest zalogowany,
  - **When** otwiera ekran listy wydarzeń (`events.html`),
  - **Then** widzi listę wydarzeń.
- **AC-F4-2**
  - **Given** użytkownik jest na liście wydarzeń,
  - **When** używa wyszukiwania lub filtrów (kategoria, język, dostępność),
  - **Then** lista wydarzeń pokazuje tylko pozycje spełniające kryteria.
- **AC-F4-3**
  - **Given** użytkownik jest na liście wydarzeń,
  - **When** wybiera wydarzenie,
  - **Then** widzi ekran szczegółów wydarzenia (`event-details.html`) z tytułem, opisem, datą/godziną, lokalizacją, organizatorem i atrybutami dostępności oraz języka.

### F5. Zapis na wydarzenie i podgląd wejściówki
- **AC-F5-1**
  - **Given** użytkownik jest na ekranie szczegółów wydarzenia,
  - **When** wybiera akcję „Zapisz się”,
  - **Then** system rejestruje zapis i pokazuje informację o powodzeniu.
- **AC-F5-2**
  - **Given** zapis użytkownika na wydarzenie został potwierdzony,
  - **When** użytkownik otwiera wejściówkę,
  - **Then** widzi ekran wejściówki (`event-ticket.html`) z unikalnym kodem QR.
- **AC-F5-3**
  - **Given** wydarzenie ma limit miejsc osiągnięty,
  - **When** użytkownik próbuje się zapisać,
  - **Then** system blokuje zapis i wyświetla informację o braku miejsc.

### F6. Przeglądanie poradników
- **AC-F6-1**
  - **Given** użytkownik jest zalogowany,
  - **When** otwiera ekran poradników (`guides.html`),
  - **Then** widzi listę poradników.

---

## 4) Definicja „DONE” dla flow

### F1. Pierwsze logowanie / rejestracja przez SSO
Flow jest „DONE”, gdy:
- wszystkie AC-F1-* są spełnione,
- brak krytycznych błędów blokujących logowanie,
- zachowanie jest spójne z opisem SSO w `docs/specs.md`.

### F2. Logowanie użytkownika (SSO)
Flow jest „DONE”, gdy:
- wszystkie AC-F2-* są spełnione,
- brak krytycznych błędów blokujących logowanie,
- zachowanie nie wymaga lokalnego hasła.

### F3. Przeglądanie aktualności
Flow jest „DONE”, gdy:
- wszystkie AC-F3-* są spełnione,
- lista i filtry działają zgodnie z `news.html` i specyfikacją.

### F4. Przeglądanie wydarzeń i szczegółów wydarzenia
Flow jest „DONE”, gdy:
- wszystkie AC-F4-* są spełnione,
- szczegóły wydarzenia zawierają wszystkie pola wymagane w `docs/specs.md`.

### F5. Zapis na wydarzenie i podgląd wejściówki
Flow jest „DONE”, gdy:
- wszystkie AC-F5-* są spełnione,
- zapis nie pozwala na przekroczenie limitu miejsc,
- wejściówka zawiera unikalny kod QR.

### F6. Przeglądanie poradników
Flow jest „DONE”, gdy:
- wszystkie AC-F6-* są spełnione,
- lista poradników jest widoczna i dostępna do przewijania.

---

## 5) Ryzyka i redukcja przez AC
- **Różne interpretacje tego samego flow** → redukowane przez precyzyjne AC-F3-1, AC-F4-3 (konkretne ekrany i pola) oraz AC-F5-2 (jednoznaczny efekt wejściówki).
- **„DONE” zależne od osoby oceniającej** → redukowane przez definicje DONE i komplet AC-F1-* do AC-F6-*.
- **Brak możliwości napisania testów** → redukowane przez scenariusze testowe 1:1 mapujące się na AC.

---

## 6) Plan testów (scenariusze Given / When / Then)

1. **TS-F1-1 (AC-F1-1):**
   - **Given** użytkownik nie ma aktywnej sesji,
   - **When** poprawnie uwierzytelnia się przez SSO,
   - **Then** konto zostaje utworzone, rola przypisana, a użytkownik widzi ekran główny.
2. **TS-F1-2 (AC-F1-2):**
   - **Given** użytkownik nie ma aktywnej sesji,
   - **When** logowanie w SSO kończy się błędem,
   - **Then** użytkownik pozostaje niezalogowany i widzi komunikat błędu.
3. **TS-F2-1 (AC-F2-1):**
   - **Given** użytkownik jest wylogowany,
   - **When** poprawnie uwierzytelnia się przez SSO,
   - **Then** aplikacja otwiera ekran główny.
4. **TS-F2-2 (AC-F2-2):**
   - **Given** użytkownik jest zalogowany,
   - **When** uruchamia aplikację ponownie,
   - **Then** widzi ekran główny bez ponownego logowania.
5. **TS-F3-1 (AC-F3-1):**
   - **Given** użytkownik jest zalogowany,
   - **When** otwiera ekran aktualności,
   - **Then** widzi listę aktualności.
6. **TS-F3-2 (AC-F3-2):**
   - **Given** użytkownik jest na ekranie aktualności,
   - **When** wybiera filtr kategorii,
   - **Then** lista aktualności pokazuje tylko pasujące pozycje.
7. **TS-F3-3 (AC-F3-3):**
   - **Given** użytkownik widzi listę aktualności,
   - **When** oznacza aktualność jako przeczytaną,
   - **Then** status aktualności zmienia się na „przeczytana”.
8. **TS-F4-1 (AC-F4-1):**
   - **Given** użytkownik jest zalogowany,
   - **When** otwiera listę wydarzeń,
   - **Then** widzi listę wydarzeń.
9. **TS-F4-2 (AC-F4-2):**
   - **Given** użytkownik jest na liście wydarzeń,
   - **When** używa wyszukiwania lub filtrów,
   - **Then** lista pokazuje tylko pasujące wydarzenia.
10. **TS-F4-3 (AC-F4-3):**
   - **Given** użytkownik jest na liście wydarzeń,
   - **When** wybiera wydarzenie,
   - **Then** widzi szczegóły wydarzenia z wymaganymi polami.
11. **TS-F5-1 (AC-F5-1):**
   - **Given** użytkownik jest na szczegółach wydarzenia,
   - **When** wybiera „Zapisz się”,
   - **Then** zapis jest potwierdzony i wyświetlany.
12. **TS-F5-2 (AC-F5-2):**
   - **Given** użytkownik ma potwierdzony zapis,
   - **When** otwiera wejściówkę,
   - **Then** widzi kod QR wejściówki.
13. **TS-F5-3 (AC-F5-3):**
   - **Given** wydarzenie jest pełne,
   - **When** użytkownik próbuje się zapisać,
   - **Then** system blokuje zapis i informuje o braku miejsc.
14. **TS-F6-1 (AC-F6-1):**
   - **Given** użytkownik jest zalogowany,
   - **When** otwiera ekran poradników,
   - **Then** widzi listę poradników.
