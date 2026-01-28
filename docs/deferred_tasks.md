# Deferred Tasks — PW_hub
*Świadomie odłożone zadania / epiki*

## Cel dokumentu

Ten dokument gromadzi **zadania i obszary funkcjonalne, które są już znane,
opisane i często mają swoje issues**, ale zostały **świadomie odłożone na później**.

Nie są to „zapomniane TODO”, lecz **kontrolowany backlog strategiczny**.

Dokument służy do:
- ochrony zakresu MVP przed scope creep,
- uzasadniania decyzji projektowych (ADR, MVP/MMF),
- synchronizacji z interesariuszami (BKiP, CI, Samorząd),
- planowania kolejnych inkrementów (MMF).

---

## Zasada interpretacji

Jeśli coś znajduje się w tym pliku:
- **nie wchodzi do MVP**,  
- **nie jest blokadą techniczną**,  
- **nie wymaga decyzji teraz**,  
ale:
- **zostanie zrobione**, gdy spełnione zostaną warunki wejścia.

---

## 1. Mapy kampusu i nawigacja

### Status
**ODŁOŻONE — MMF**

### Zakres (docelowy)
- mapa kampusów i budynków PW,
- punkty POI (dziekanaty, stołówki, koła, usługi),
- trasy piesze,
- trasy dostępne (ograniczenia ruchowe),
- integracja z danymi CENAGIS / GiK.

### Dlaczego nie teraz
- wysoki koszt danych i integracji,
- zależność od właściciela danych (GiK),
- **nie jest krytyczne dla walidacji głównego JTBD**:
  „orientacja informacyjna + udział w wydarzeniach”.

### Warunki wejścia
- stabilne MVP wydarzeń i zapisów,
- potwierdzona adopcja aplikacji,
- formalne uzgodnienie zakresu danych mapowych.

### Referencje
- MMF-2: Mapy i nawigacja
- Non-Goals (MVP)
- MoSCoW: *Could Have*

---

## 2. Integracja z USOS API (tryb informacyjny)

### Status
**ODŁOŻONE — MMF**

### Zakres (docelowy)
- podgląd terminów akademickich,
- przypomnienia (zapisy, egzaminy, opłaty),
- synchronizacja **wyłącznie read-only**.

### Dlaczego nie teraz
- integracja wymaga:
  - formalnych uzgodnień,
  - review bezpieczeństwa,
  - stabilnej aplikacji po stronie PW_hub,
- **komisja BZIK wprost wskazała**, że USOS nie powinien być warunkiem MVP,
- ryzyko organizacyjne > wartość na etapie MVP.

### Warunki wejścia
- działające MVP bez integracji,
- jasny JTBD powiązany z danymi USOS,
- zgoda CI PW i właściciela API.

### Referencje
- MMF-3: Integracja z USOS
- Non-Goals (MVP)
- Assumption A4 (High Impact / Low Certainty)

---

## 3. Logowanie przez konta uczelniane (SSO)

### Status
**ODŁOŻONE — etap przejścia do MVP produkcyjnego**

### Zakres
- logowanie przez:
  - CAS USOSweb **lub**
  - Microsoft Entra ID,
- automatyczne przypisanie ról,
- brak lokalnych kont i haseł.

### Dlaczego nie teraz
- w realiach dużej uczelni publicznej:
  - aplikacja musi być **funkcjonalnie kompletna**,
  - stabilna,
  - przetestowana,
- SSO to **krok formalno-organizacyjny**, nie prototypowy,
- integracja bez gotowego produktu jest nierealna.

### Warunki wejścia
- kompletny prototyp funkcjonalny (pre-MVP),
- realne testy wydarzeń i zapisów,
- akceptacja interesariuszy merytorycznych,
- gotowość CI PW do integracji.

### Referencje
- **ADR-003: Wyłączenie SSO z zakresu MVP**
- RICE: SSO jako etap końcowy
- Context Diagram
- AC-1 (docelowo)

---

## 4. Status zbiorczy

| Obszar            | Status        | Etap docelowy |
|-------------------|---------------|---------------|
| Mapy kampusu      | Odłożone      | MMF-2         |
| USOS API          | Odłożone      | MMF-3         |
| Logowanie SSO     | Odłożone      | Pre-prod MVP  |

---

## Zasada aktualizacji

- Każdy element **opuszczający ten dokument**:
  - trafia do backlogu sprintowego **albo**
  - dostaje własny ADR.
- Każde nowe „a może jeszcze…”:
  - **najpierw trafia tutaj**, nie do MVP.

> Brak wpisu w tym pliku **nie oznacza zgody** na realizację funkcji.
