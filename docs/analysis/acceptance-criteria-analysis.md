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
- przegląd aktualności,
- przegląd, filtrowanie i wyszukiwanie wydarzeń,
- zapisy / rezygnacje z wydarzeń,
- wejściówki QR,
- mapa kampusu,
- powiadomienia,
- informacyjny podgląd danych z USOS.

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
