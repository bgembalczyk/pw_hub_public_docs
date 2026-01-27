# Analiza MoSCoW — PW Hub (Aplikacja Companion PW)

## 1. Cel i rola dokumentu

Celem analizy **MoSCoW** jest **jednoznaczne uporządkowanie zakresu MVP**
dla projektu **PW Hub** oraz ochrona tego zakresu przed rozrostem
(scope creep).

Dokument:

- definiuje **priorytety dostarczania funkcjonalności**,
- stanowi **kontrakt zakresowy** między interesariuszami a zespołem,
- jest punktem odniesienia dla:
    - planowania iteracji,
    - decyzji architektonicznych (ADR),
    - kryteriów akceptacji (AC).

Analiza dotyczy **wyłącznie MVP** i nie opisuje roadmapy długoterminowej.

---

## 2. Zakres systemu objętego analizą

Analiza obejmuje system **PW Hub** rozumiany jako całość:

- aplikacja mobilna dla studentów (Flutter),
- backend (Django + DRF),
- panele webowe Django (DTL) dla:
    - jednostek i organizatorów treści,
    - administratorów merytorycznych.

Poza zakresem analizy:

- kwestie stricte implementacyjne,
- decyzje techniczne niskiego poziomu,
- funkcje wykraczające poza MVP (opisane jako Won’t).

---

## 3. Źródła (Source of Truth)

Priorytety MoSCoW wynikają bezpośrednio z następujących dokumentów projektu:

- Problem Statement — PW Hub
- Analiza JTBD
- MVP / MMF
- Non-Goals
- Context Diagram
- Stakeholder Analysis
- Acceptance Criteria (AC)

Analiza **nie wprowadza nowych wymagań** —
porządkuje istniejące.

---

## 4. Założenia bazowe

- MVP koncentruje się na:
    - centralizacji informacji,
    - aktywizacji studentów poprzez **wydarzenia**.
- Moduł `events` jest jedynym modułem **write-enabled**
  (zapisy, wejściówki, stan użytkownika).
- Pozostałe moduły (`announcements`, `guides`) są w MVP **read-only**.
- Integracje zewnętrzne (USOS, dane mapowe) mają charakter **informacyjny**.
- Dostępność (WCAG 2.1 AA) jest **wymaganiem jakościowym**, nie opcją.

---

## 5. MUST HAVE

**Elementy krytyczne — bez nich MVP nie spełnia celu projektu**

| Element                                | Uzasadnienie                                     |
|----------------------------------------|--------------------------------------------------|
| Logowanie SSO (CAS / Entra ID)         | Wymóg organizacyjny; brak lokalnych kont i haseł |
| Centralne repozytorium treści          | Realizacja głównego Problem Statement            |
| System aktualności (read-only)         | Podstawowa orientacja informacyjna studentów     |
| Moduł wydarzeń (events)                | Kluczowy obszar aktywizacji użytkowników         |
| Lista / kalendarz wydarzeń + szczegóły | Podstawowy scenariusz JTBD                       |
| Zapisy i rezygnacje z wydarzeń         | Jedyna operacja modyfikująca stan użytkownika    |
| Limity miejsc i status dostępności     | Wymóg organizacyjny wydarzeń                     |
| Wejściówki z kodem QR                  | Obsługa wejścia na wydarzenie                    |
| Panel webowy Django (CRUD wydarzeń)    | Niezbędny dla autorów treści                     |
| Podstawowe role i uprawnienia          | Ochrona danych i kontroli dostępu                |
| Obsługa błędów integracji (read-only)  | Stabilność MVP                                   |
| Zgodność z WCAG 2.1 AA (MVP scope)     | Wymóg formalny i jakościowy                      |

> Jeśli którykolwiek z powyższych elementów nie zostanie dostarczony,
> **produkt nie spełnia definicji MVP**.

---

## 6. SHOULD HAVE

**Bardzo ważne — znacząco podnoszą wartość, ale nie blokują MVP**

| Element                                             | Uzasadnienie                       |
|-----------------------------------------------------|------------------------------------|
| Filtrowanie wydarzeń (kategoria, język, dostępność) | Wspiera orientację i planowanie    |
| Wyszukiwanie wydarzeń                               | Skraca czas dotarcia do informacji |
| Wielojęzyczność treści (PL / EN)                    | Wspiera inkluzywność               |
| Lista uczestników dla organizatora                  | Wymóg operacyjny wydarzeń          |
| Weryfikacja wejściówek (QR scan / status)           | Ułatwia obsługę wydarzeń           |
| Moderacja treści                                    | Kontrola jakości informacji        |
| Zarządzanie rolami w panelu                         | Skalowalność organizacyjna         |

---

## 7. COULD HAVE

**Opcjonalne — realizowane tylko przy nadwyżce czasu/budżetu**

| Element                                 | Uzasadnienie                   |
|-----------------------------------------|--------------------------------|
| Mapy kampusu                            | Wsparcie kontekstu wydarzeń    |
| Prosta nawigacja piesza                 | Wartość dodatkowa UX           |
| Powiadomienia push                      | Zwiększają frekwencję          |
| Przypomnienia o zapisanych wydarzeniach | Komfort użytkownika            |
| Rozszerzone statystyki                  | Przydatne, ale brak JTBD w MVP |

---

## 8. WON’T HAVE (this time)

**Świadomie poza zakresem MVP**

| Element                                     | Powód                           |
|---------------------------------------------|---------------------------------|
| Zastępowanie USOS                           | Poza celem projektu             |
| Dwukierunkowa integracja z USOS             | Wysokie ryzyko organizacyjne    |
| Płatności / e-commerce                      | Brak JTBD i właściciela         |
| Funkcje społecznościowe (czaty, komentarze) | Scope creep, koszty moderacji   |
| Obsługa innych uczelni                      | MVP jednoznacznie dedykowane PW |
| Zaawansowana analityka BI                   | Brak wartości krytycznej w MVP  |

---

## 9. Konsekwencje i zasady interpretacji

- **Must** definiują granicę MVP i są nienegocjowalne.
- **Should** są pierwszym kandydatem do kolejnej iteracji.
- **Could** wypadają jako pierwsze przy presji czasowej.
- **Won’t** materializują dokument *Non-Goals*.

Każda próba:

- podniesienia elementu z Should/Could do Must
  wymaga:
- zmiany celu MVP **lub**
- nowej decyzji interesariuszy
  i powinna zostać utrwalona w **ADR**.

---

## 10. Ryzyka i otwarte punkty

- Zakres minimalnej funkcjonalności map (statyczne vs routing).
- Harmonogram i stabilność integracji read-only z USOS.
- Priorytety panelu administratora merytorycznego przy ograniczonym czasie.
- Oczekiwania użytkowników wobec interakcji poza modułem `events`.

---

## 11. Relacje z innymi artefaktami

- MoSCoW → **definiuje zakres**
- ADR → **utrwala decyzje zakresowe**
- Acceptance Criteria → **operacjonalizują Must/Should**
- Non-Goals → **formalizują Won’t**

> Ten dokument jest **aktywny tylko dla etapu MVP**  
> i wymaga aktualizacji przy zmianie celu etapu.
