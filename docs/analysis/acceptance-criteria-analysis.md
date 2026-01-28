# Analiza Acceptance Criteria (AC) — PW_hub

## 1. Rola dokumentu
Acceptance Criteria (AC) definiują **obiektywne i testowalne warunki uznania zakresu MVP
PW_hub za zrealizowany**.

AC:
- wynikają z User Stories i JTBD,
- stanowią kontrakt między Product / UX / Dev / QA,
- wyznaczają granicę „done” dla MVP.

Jeśli coś **nie spełnia AC → nie jest uznane za dostarczone**.

---

## 2. Źródła (Source of Truth)
Acceptance Criteria wynikają z następujących dokumentów projektu:
- **User Stories — MVP** (Student / Organizator / Administrator),
- **Problem Statement — PW_hub**,
- **Analiza JTBD**,
- **Non-Goals**,
- **Context Diagram**,
- **Stakeholder Analysis**.

AC **nie rozszerzają zakresu** względem powyższych dokumentów.

---

## 3. Acceptance Criteria (MVP)

### AC-1: Dostępność funkcji MVP na Android i iOS

**Given**
- użytkownik korzysta z aplikacji mobilnej PW_hub,
- urządzenie spełnia minimalne wymagania:
  - Android ≥ 9,
  - iOS ≥ 15,

**When**
- użytkownik wykonuje funkcje zdefiniowane w **User Stories MVP dla Studenta**,

**Then**
- wszystkie funkcje MVP są dostępne i możliwe do wykonania,
- aplikacja nie zawiera błędów blokujących (crash, brak reakcji, utrata danych),
- zachowanie funkcji jest spójne między Android i iOS.

Zakres funkcji objętych AC:
- logowanie SSO,
- onboarding profilu studenta (wydział/rok/grupa opcjonalnie),
- przegląd aktualności,
- przegląd, filtrowanie i wyszukiwanie wydarzeń,
- zapisy / rezygnacje z wydarzeń,
- wejściówki QR,
- mapa kampusu,
- powiadomienia,
- informacyjny podgląd danych z USOS.

---

### AC-1a: Kalendarz wydarzeń z filtrowaniem (P1 — odkrywanie)

**Given**
- użytkownik jest w module listy wydarzeń,

**When**
- wybiera filtr „Wydział/Jednostka”,

**Then**
- lista pokazuje tylko wydarzenia przypisane do tej jednostki,
- licznik wyników odpowiada zastosowanym filtrom.

**Given**
- aktywne są filtry wydział + kategoria,

**When**
- użytkownik zmienia zakres dat (np. dziś / tydzień / miesiąc lub zakres niestandardowy),

**Then**
- lista i licznik aktualizują się zgodnie z nowymi kryteriami (filtry łączone AND),
- kolejność wyników pozostaje chronologiczna.

**Given**
- filtry zawężają listę do pustego zbioru,

**When**
- lista się odświeża,

**Then**
- użytkownik widzi czytelny stan „brak wydarzeń” bez błędów,
- użytkownik ma opcję wyczyszczenia filtrów.

**Given**
- użytkownik otwiera szczegóły wydarzenia,

**When**
- przegląda ekran szczegółów,

**Then**
- widzi pełny opis, datę/zakres dat, lokalizację, organizatora oraz kategorie/tagi,
- nie widzi funkcji rejestracji, biletów ani QR (out of scope dla P1).

**Given**
- użytkownik wybiera zakres dat niepoprawny (data od > data do),

**When**
- system waliduje zakres,

**Then**
- użytkownik widzi komunikat o błędzie walidacji,
- nie jest wykonywane zapytanie lub API zwraca 400 z błędem walidacji.

---

### AC-2: Dostępność (WCAG 2.1)

**Given**
- aplikacja mobilna i panele webowe obejmują ekrany MVP
  (aktualności, wydarzenia, szczegóły, zapisy, mapa, panele CRUD),

**When**
- przeprowadzono testy dostępności wg **WCAG 2.1 na poziomie AA**,

**Then**
- nie występują krytyczne naruszenia WCAG (blokujące użycie),
- wszystkie wykryte problemy są:
  - naprawione **lub**
  - jawnie zaakceptowane jako ryzyko (z uzasadnieniem).

Zakres dostępności obejmuje m.in.:
- obsługę klawiatury,
- kontrast,
- opisy alternatywne,
- czytelność komunikatów,
- brak barier w podstawowych ścieżkach użytkownika.

---

### AC-3: Integracje zewnętrzne (tryb informacyjny)

**Zakres integracji MVP:**
- USOS (dane informacyjne),
- system powiadomień (e-mail / SMS / push),
- dane mapowe kampusu (CENAGIS / GiK).

#### Scenariusze pozytywne

**Given**
- integracja jest skonfigurowana,
- system zewnętrzny jest dostępny,

**When**
- system pobiera dane,

**Then**
- dane są prezentowane:
  - w poprawnym formacie,
  - w aktualnej wersji,
  - bez modyfikacji po stronie PW_hub.

#### Scenariusze negatywne

**Given**
- integracja zwraca błąd (timeout / 4xx / 5xx),

**When**
- użytkownik próbuje skorzystać z funkcji zależnej od integracji,

**Then**
- użytkownik otrzymuje czytelny komunikat (bez detali technicznych),
- aplikacja pozostaje używalna,
- błąd jest logowany zgodnie ze standardem projektu.

---

### AC-4: Uprawnienia i bezpieczeństwo

**Given**
- użytkownik posiada określoną rolę (Student / Organizator / Administrator),

**When**
- wykonuje akcję w systemie,

**Then**
- system pozwala tylko na operacje zgodne z rolą,
- brak możliwości dostępu do cudzych wydarzeń, zapisów lub danych,
- dane osobowe są przetwarzane minimalnie (RODO).

---

### AC-5: Spójność UX i informacji

**Given**
- użytkownik korzysta z aplikacji lub panelu,

**When**
- wykonuje kluczowe ścieżki MVP,

**Then**
- system:
  - jasno komunikuje statusy (zapisany, brak miejsc, błąd),
  - nie wymaga szkolenia ani instrukcji,
  - nie zmusza do korzystania z zewnętrznych narzędzi.

---

### AC-6: Onboarding profilu studenta (P1)

**Given**
- użytkownik loguje się do aplikacji po raz pierwszy,
- profil studenta nie zawiera wydziału i roku studiów,

**When**
- użytkownik przechodzi onboarding,

**Then**
- profil zapisuje **wydział** i **rok studiów** jako wymagane,
- **grupa** jest zapisana tylko jeśli użytkownik ją wybierze (pole opcjonalne),
- onboarding kończy się w maksymalnie 1–3 krokach.

**Given**
- użytkownik przerwa onboarding przed zapisaniem profilu,

**When**
- wraca do aplikacji,

**Then**
- onboarding jest ponownie oferowany,
- treści pozostają **niepersonalizowane** do czasu uzupełnienia profilu.

**Given**
- użytkownik ma uzupełniony profil,

**When**
- przegląda listę wydarzeń,

**Then**
- domyślnie zastosowany jest filtr **wydziału** użytkownika,
- użytkownik może zmienić filtr ręcznie (poza zakresem implementacji P1).

---

### AC-7: Moderacja i publikacja treści (administrator merytoryczny)

**Given**
- administrator merytoryczny jest zalogowany do panelu Django,
- treść lub wydarzenie posiada status „do moderacji”,

**When**
- administrator ocenia treść,

**Then**
- może wykonać jedną z akcji: **zaakceptować**, **odrzucić** lub **poprosić o poprawę**,
- każda decyzja wymaga uzasadnienia widocznego dla autora/organizatora,
- status treści zmienia się zgodnie z decyzją.

**Given**
- treść jest opublikowana,

**When**
- administrator cofa publikację,

**Then**
- treść traci status „opublikowana”,
- decyzja cofnięcia jest zapisana z uzasadnieniem.

---

### AC-7: Obsługa błędów i walidacja (MVP)

**Given**
- użytkownik wykonuje akcję zdefiniowaną w User Stories MVP,

**When**
- przekazuje błędne dane wejściowe **lub**
- nie posiada wymaganych uprawnień **lub**
- wystąpi błąd integracji zewnętrznej,

**Then**
- system zwraca **spójny status HTTP** zgodny z kategorią błędu (400/403/404/409/5xx),
- odpowiedź błędu nie ujawnia detali technicznych,
- błąd jest logowany po stronie serwera z kontekstem,
- scenariusze negatywne są objęte testami (unit + integration).

Szczegóły scenariuszy i formatów błędów: `docs/negative-test-plan.md`.

---

## 4. Kryteria wykluczeń (Non-Goals w AC)
Acceptance Criteria **nie obejmują**:
- płatności i e-commerce,
- czatu i komunikacji synchronicznej,
- zaawansowanej analityki BI,
- integracji modyfikujących dane w USOS,
- obsługi innych uczelni niż PW.

Brak AC w tych obszarach jest **świadomą decyzją projektową**.

---

## 5. Status AC
- AC obejmują **pełny i zamknięty zakres MVP**.
- Każde rozszerzenie AC wymaga:
  - nowego JTBD **lub**
  - decyzji interesariuszy produktowych.

---

## 6. Rekomendacja dalszych kroków
1. Przypisać Acceptance Criteria do **konkretnych User Stories**.
2. Przepisać AC do **Gherkin (Given / When / Then)** per historia.
3. Zmapować AC → testy manualne i automatyczne.
4. Traktować ten dokument jako **Definition of Done dla MVP**.
