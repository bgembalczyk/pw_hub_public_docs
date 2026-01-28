# Hierarchia przycisków w kluczowych widokach PW_hub

## Kontekst i źródła

Ten dokument ujednolica hierarchię przycisków (primary / secondary / tertiary) w
najczęściej używanych widokach aplikacji. Zakres oparty jest na:
- **MVP/MMF** i kluczowych funkcjach użytkowników,
- **User Journey Maps** (student, panel jednostki, panel administratora),
- **mock-upach** aplikacji mobilnej i paneli webowych.

## Role i odpowiedzialności (wymuszone przez proces)

- **UX Designer (UX Pathfinder)** — definiuje przepływy i cele ekranów.
- **Interaction Designer (UX Pathfinder)** — minimalizuje ryzyko błędnych kliknięć.
- **Frontend Engineer (Frontend Cybermonk)** — wskazuje miejsca w kodzie do ujednolicenia.
- **Accessibility Reviewer (Accessibility Oathkeeper)** — weryfikuje kontrast, fokus, semantykę.
- **Product Owner (Product Questmaster)** — zatwierdza, co jest „główną” akcją na ekranie.

## 1) Identyfikacja kluczowych widoków (MVP/MMF)

### A. Student (Flutter)
Najczęściej używane widoki i cele:
1. **Home / Start** — szybkie przejście do głównych sekcji (wydarzenia, aktualności).
2. **Lista aktualności** — odnalezienie istotnej informacji.
3. **Lista wydarzeń** — wybór wydarzenia do oceny.
4. **Szczegóły wydarzenia** — podjęcie decyzji o udziale.
5. **Wejściówka (QR)** — okazanie biletu, kontakt z organizatorem.
6. **Feedback po wydarzeniu** — szybkie potwierdzenie doświadczenia.

**Krytyczne dla MVP:** 2–5.

### B. Panel jednostki (Django)
Najczęściej używane widoki i cele:
1. **Dashboard jednostki** — szybkie tworzenie treści.
2. **Zarządzanie wydarzeniami** — publikacja i aktualizacja wydarzeń.
3. **Zarządzanie aktualnościami** — publikacja i aktualizacja ogłoszeń.
4. **Zarządzanie zapisami** — kontrola listy uczestników.
5. **Weryfikacja wejściówek** — potwierdzanie udziału.

**Krytyczne dla MVP:** 1–3.

### C. Panel administratora merytorycznego (Django)
Najczęściej używane widoki i cele:
1. **Dashboard admina** — szybkie wejście w moderację.
2. **Moderacja treści** — decyzje publikacyjne.
3. **Zarządzanie jednostkami** — utrzymanie struktury organizacyjnej.
4. **Zarządzanie użytkownikami/rolami** — kontrola dostępu.

**Krytyczne dla MVP:** 1–2.

## 2) Definicje i klasyfikacja akcji

### Primary
- **Jedna na widok** (maksymalnie).
- Odpowiada głównemu celowi użytkownika na ekranie.
- Wymaga najwyższego kontrastu i największej wagi wizualnej.

### Secondary
- Akcje wspierające, alternatywne lub wykonywane często, ale nie kluczowe.
- Wizualnie lżejsze niż primary.

### Tertiary
- Akcje pomocnicze/nawigacyjne.
- Nigdy nie konkurują wizualnie z primary.

**Reguła projektowa:**
Jeśli na ekranie są dwie „równie ważne” akcje, wymaga to decyzji Product Ownera
oraz korekty flow.

## 3) Zasady wizualne (systemowe, niezależne od widoku)

### Primary
- **Styl:** `btn-primary` (pełny kolor wiodący).
- **Kontrast:** najwyższy; tekst zawsze czytelny.
- **Placement:** pierwszy w kolejności tabulacji w sekcji CTA.
- **Loading:** widoczny spinner + blokada ponownych kliknięć.

### Secondary
- **Styl:** `btn-outline-primary` lub `btn-secondary` (neutralny).
- **Kontrast:** niższy niż primary, ale nadal dostępny.
- **Placement:** obok primary, ale z mniejszym ciężarem.

### Tertiary
- **Styl:** `btn-link`, tekstowy link lub ghost.
- **Kontrast:** wystarczający, ale bez dominacji.
- **Placement:** poniżej lub poza główną strefą CTA.

### Akcje destrukcyjne
- Wariant secondary z kolorem „danger” (`btn-outline-danger`) i potwierdzeniem.
- **Nigdy** nie jako primary.

## 4) Stany przycisków (wszystkie typy)

| Stan | Kiedy występuje | Komunikacja |
| --- | --- | --- |
| Default | Standardowy stan gotowości | Czytelna etykieta i ikonografia (opcjonalnie) |
| Hover / Pressed | Po najechaniu/kliknięciu | Zmiana tła/obrysu, zachowany kontrast |
| Disabled | Brak możliwości akcji | Zmniejszony kontrast + `aria-disabled` + wyjaśnienie w UI |
| Loading | Trwa operacja | Spinner + `aria-busy="true"` + blokada wielokrotnego kliknięcia |

## 5) Mapowanie: widok → akcje → typ przycisku

### A. Student (Flutter)

| Widok | Główny cel | Primary | Secondary | Tertiary |
| --- | --- | --- | --- | --- |
| Home / Start | Wejście w najważniejszą ścieżkę | **Wydarzenia** (wejście do listy) | Aktualności | Inne kafelki/nawigacja |
| Lista aktualności | Przejrzenie treści | **Otwórz szczegóły aktualności** (tap na karcie) | Filtruj | Ustawienia/lista (ikony navbar) |
| Lista wydarzeń | Wybrać wydarzenie do oceny | **Otwórz szczegóły wydarzenia** (tap na karcie) | Zapisz się (CTA na karcie) | Dodaj do kalendarza |
| Szczegóły wydarzenia | Decyzja o udziale | **Zapisz się / Zrezygnuj** | Dodaj do kalendarza | Zadaj pytanie / Zobacz więcej / Pomocne |
| Wejściówka (QR) | Okazanie biletu | **Pokaż wejściówkę** (stan widoku) | Skontaktuj się z organizatorami | Nawigacja dolna |
| Feedback po wydarzeniu | Szybka opinia | **Wyślij opinię** | Pomiń | Wróć |

### B. Panel jednostki (Django)

| Widok | Główny cel | Primary | Secondary | Tertiary |
| --- | --- | --- | --- | --- |
| Dashboard jednostki | Szybkie tworzenie treści | **Nowe wydarzenie** | Nowa aktualność | Zarządzaj użytkownikami |
| Zarządzanie wydarzeniami | Publikacja wydarzeń | **Utwórz nowe wydarzenie** | Edytuj / Publikuj / Zamknij zapisy | Podgląd / Eksport / Import |
| Zarządzanie aktualnościami | Publikacja ogłoszeń | **Utwórz nową aktualność** | Edytuj / Publikuj / Archiwizuj | Podgląd / Eksport / Kategorie |
| Zarządzanie zapisami | Kontrola listy uczestników | **Lista uczestników** | Eksport / Powiadom uczestników | Filtry |
| Weryfikacja wejściówek | Potwierdzenie udziału | **Zweryfikuj kod** | Odrzuć / Oznacz problem | Powrót |

### C. Panel administratora merytorycznego (Django)

| Widok | Główny cel | Primary | Secondary | Tertiary |
| --- | --- | --- | --- | --- |
| Dashboard admina | Szybkie wejście w moderację | **Moderuj teraz** | Weryfikuj konta / Przejdź do zgłoszeń | Raporty / Zobacz |
| Moderacja treści | Decyzja publikacyjna | **Podgląd szczegółów** | Zatwierdź / Odrzuć / Edytuj | Akcje masowe / Eksport |
| Zarządzanie jednostkami | Utrzymanie struktury | **Dodaj nową jednostkę** | Edytuj / Podgląd / Statystyki | Import / Eksport |
| Użytkownicy i role | Kontrola dostępu | **Zatwierdź/Przyznaj rolę** | Edytuj / Dezaktywuj | Eksport |

> **Uwaga:** Primary w listach jest zawsze akcją, która minimalizuje ryzyko błędnego
> kliknięcia (np. „Podgląd” zamiast natychmiastowej publikacji).

## 6) Zasady spójności i anti-patterns

**Do:**
- Jeden primary na ekran.
- Sekwencja interakcji: primary → secondary → tertiary w tab order.
- Destrukcja zawsze secondary + potwierdzenie.

**Don’t:**
- Dwie akcje o tym samym ciężarze.
- Primary użyty do nawigacji pobocznej.
- Brak stanu loading/disabled przy akcjach sieciowych.

## 7) Accessibility (hierarchia wizualna = hierarchia dostępności)

- **Focus ring** widoczny na wszystkich typach przycisków.
- **Tab order** zgodny z hierarchią (primary jako pierwszy).
- **ARIA**: `aria-busy` dla loading, `aria-disabled` dla disabled.
- **Kontrast**: minimum WCAG 2.1 AA dla tekstu i obrysu.

## 8) Lista miejsc w kodzie wymagających ujednolicenia

### A. Komponenty bazowe
- `pw_hub/templates/allauth/elements/button.html` — mapowanie tagów na klasy (primary/secondary). 

### B. Panel jednostki
- `pw_hub/templates/unit_panel/dashboard.html` — szybkie akcje w dashboardzie.
- `pw_hub/templates/unit_panel/events.html` — CTA w listach i akcjach masowych.
- `pw_hub/templates/unit_panel/users.html` — mix klas i brak konsekwencji w akcjach użytkowników.

### C. Panel administratora
- `pw_hub/templates/content_admin/configuration.html` — przyciski zakładek i akcje konfiguracyjne.
- `pw_hub/templates/content_admin/unit_detail.html` — nawigacja i powrót.

### D. Widoki domenowe (wydarzenia/aktualności)
- `pw_hub/announcements/views.py` — etykiety i CTA w listach/edycji.
- `pw_hub/events/views.py` — CTA w listach/edycji.

## 9) Check końcowy (ścieżki krytyczne)

- **Student:** lista wydarzeń → szczegóły → zapis → wejściówka.
- **Organizator:** dashboard → utwórz wydarzenie → publikuj → lista uczestników.
- **Administrator:** dashboard → moderacja → decyzja publikacyjna.

Jeśli w którymkolwiek miejscu **secondary wygląda jak primary**, należy
skorygować klasy i kolejność w UI.
