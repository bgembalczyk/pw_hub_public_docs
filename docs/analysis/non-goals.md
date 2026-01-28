# Analiza Non-Goals — PW_hub

## 1. Cel dokumentu
Celem dokumentu jest **jawne zdefiniowanie elementów poza zakresem (Non-Goals)** projektu PW_hub,
aby:
- ograniczyć **scope creep**,
- ułatwić podejmowanie decyzji zakresowych,
- zapewnić spójność planowania, implementacji i ewaluacji MVP.

Dokument ma charakter **decyzyjny**, a nie opisowy.

---

## 2. Źródła zakresu (Source of Truth)
Zakres projektu oraz decyzje o Non-Goals wynikają z następujących artefaktów:
- `docs/docs.md` — *Wymagania i koncepcja wdrożenia*  
  (cele projektu, zakres funkcjonalny i techniczny).

---

## 3. Zakres odniesienia (skrót kontekstowy)
PW_hub to aplikacja companion dla studentów Politechniki Warszawskiej, obejmująca:
- system aktualności,
- kalendarz wydarzeń z rejestracją i wejściówkami QR,
- informacje o dostępności wydarzeń,
- mapy kampusu i trasy piesze,
- integrację z USOS w trybie informacyjnym,
- aplikację mobilną (Flutter) dla studentów,
- panel webowy (Django DTL) dla jednostek i administratorów merytorycznych,
- backend oparty o Django + DRF.

Ten zakres stanowi **punkt odniesienia** dla wszystkich decyzji Non-Goals.

---

## 4. Non-Goals
Poniższe elementy są **świadomie i jednoznacznie poza zakresem** projektu
na obecnym etapie, zgodnie z obowiązującą dokumentacją.

### 4.1 Zastępowanie istniejących systemów akademickich (np. USOS)
PW_hub **nie ma na celu zastępowania** systemów uczelnianych.
Projekt pełni rolę narzędzia uzupełniającego i agregującego informacje.

### 4.2 Dwukierunkowa integracja z USOS (operacje modyfikujące)
Integracja z USOS ma charakter **wyłącznie informacyjny**  
(np. prezentacja danych, przypomnienia, synchronizacja informacji).
Projekt **nie obejmuje**:
- zapisów,
- edycji danych,
- operacji transakcyjnych w USOS.

### 4.3 Jedno, wspólne UI dla wszystkich ról
Nie planuje się jednego monolitycznego interfejsu dla wszystkich użytkowników.
Zakładany podział:
- aplikacja mobilna → studenci,
- panel webowy (Django DTL) → jednostki i administratorzy merytoryczni.

### 4.4 Funkcjonalności poza zdefiniowanymi modułami
Zakres funkcjonalny jest ograniczony do modułów wskazanych w wymaganiach:
- aktualności,
- wydarzenia,
- rejestracje i wejściówki QR,
- dostępność,
- mapy kampusu,
- informacyjna integracja z USOS.

Rozszerzenia wykraczające poza ten zestaw **nie są celem MVP**.

---

### 4.5 Obsługa innych uczelni niż Politechnika Warszawska w MVP
**Poza zakresem MVP.**

Projekt jest jednoznacznie:
- osadzony organizacyjnie w strukturach PW,
- zależny od interesariuszy PW (Samorząd, BKiP, CI),
- powiązany z danymi i procesami specyficznymi dla PW (USOS, CENAGIS, struktura jednostek).

Dokumenty projektowe traktują ewentualną wielouczelnianość wyłącznie jako
**potencjalny kierunek dalszego rozwoju**, nie jako cel pierwszej wersji.

---

### 4.6 Płatności, bilety płatne i e-commerce dla wydarzeń
**Poza zakresem MVP.**

Analiza JTBD oraz Problem Statement koncentrują się na:
- orientacji informacyjnej,
- aktywizacji studentów,
- ułatwieniu udziału w wydarzeniach.

Brak jest:
- JTBD związanych z płatnościami,
- interesariusza odpowiedzialnego za rozliczenia finansowe,
- analizy prawnej i księgowej (compliance, VAT, odpowiedzialność).

Wprowadzenie płatności znacząco zwiększałoby złożoność organizacyjną
i nie wspiera kluczowego problemu użytkownika.

---

### 4.7 Wbudowany czat / komunikator między studentami i organizatorami
**Poza zakresem MVP.**

W żadnym z dokumentów:
- JTBD,
- User Journey Maps,
- Problem Statement

nie pojawia się potrzeba komunikacji synchronicznej.

Dodatkowo:
- czat generuje koszty moderacji i utrzymania,
- przesuwa produkt w stronę platformy społecznościowej,
- nie wspiera głównego celu: *dostarczenia uporządkowanej informacji*.

---

### 4.8 Zaawansowana analityka i raportowanie (BI)
**Poza zakresem MVP.**

Zakres raportowania ogranicza się do:
- operacyjnych list uczestników,
- statusów zapisów niezbędnych do realizacji wydarzeń.

Zaawansowana analityka:
- nie jest powiązana z żadnym JTBD,
- nie ma wskazanego właściciela decyzyjnego,
- została wprost wskazana przez komisję BZIK jako potencjalne
  nieuzasadnione rozszerzenie zakresu kosztem wartości dla użytkownika.

---

### 4.9 Publiczny feed opinii i komentarzy do wydarzeń
**Poza zakresem MVP.**

Feedback po wydarzeniu pozostaje prywatny i agregowany.
Nie przewiduje się publicznych komentarzy ani feedu społecznościowego.

---

### 4.10 Feedback od osób nieobecnych oraz automatyczne e-maile
**Poza zakresem MVP.**

MVP nie zbiera opinii od osób bez potwierdzonej obecności (scan QR)
oraz nie wysyła automatycznych e-maili z prośbą o feedback.

---

## 5. Otwarte pytania decyzyjne
1. Czy MVP obejmuje **wyłącznie PW**, czy wymaga od razu architektury wielouczelnianej?
2. Czy organizatorzy mają dostęp do **jakichkolwiek metryk** poza listą uczestników?
3. Czy płatne wydarzenia są planowane w kolejnych iteracjach,
   czy należy je jednoznacznie wykluczyć z roadmapy?

---

## 6. Zasady utrzymania dokumentu
- Każda zmiana zakresu (funkcje, integracje, role) **wymaga aktualizacji** tego dokumentu.
- Punkty z sekcji *Non-Goals (do potwierdzenia)* po decyzji:
  - trafiają do *potwierdzone* **albo**
  - są usuwane jako nieaktualne.
- Brak zapisu w Non-Goals **nie oznacza zgody** na realizację danej funkcji.
