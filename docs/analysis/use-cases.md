# Analiza przypadków użycia — PW_hub (PW Companion)

## 1. Cel dokumentu

Celem dokumentu jest **systemowa analiza przypadków użycia (Use Cases)**
dla aplikacji **PW_hub / PW Companion**, w sposób:

- spójny z zakresem **MVP** i inkrementami **MMF**,
- zgodny z **User Stories, HTA i User Journey Maps**,
- możliwy do utrzymania i iterowania w IDE (Markdown + PlantUML).

Dokument:
- **nie zastępuje** specyfikacji funkcjonalnej,
- **nie opisuje UI ani implementacji**,
- stanowi **kontrakt zachowania systemu** dla kluczowych scenariuszy.

Diagramy Use Case znajdują się w:
`docs/diagrams/use_case.puml`.


## 2. Zakres i założenia

- Analiza obejmuje **zachowania systemu PW_hub jako całości**.
- Use Case = **cel aktora + reakcja systemu**.
- Jeden Use Case może obejmować **wiele User Stories**.
- Integracje zewnętrzne (USOS, mapy) są **read-only** i **nie blokują MVP**.
- Zakres jest jawnie podzielony na:
  - **IN (MVP)**,
  - **OUT (MMF / później)**.


## 3. Aktorzy

### 3.1 Aktorzy główni

- **Student**  
  Użytkownik aplikacji mobilnej (Flutter).  
  Konsumuje treści, zapisuje się na wydarzenia, korzysta z wejściówek QR.

- **Organizator / Pracownik jednostki**  
  Użytkownik panelu webowego (Django DTL).  
  Tworzy i zarządza wydarzeniami oraz zapisami.

- **Administrator merytoryczny**  
  Użytkownik dedykowanego panelu Django (nie Django Admin).  
  Zarządza rolami, strukturą jednostek i moderacją treści.


### 3.2 Systemy zewnętrzne (aktorzy wtórni)

- **SSO (CAS USOSweb / Microsoft Entra ID)**  
  Uwierzytelnianie użytkowników.

- **USOS (read-only)**  
  Źródło danych informacyjnych (terminy, przypomnienia).  
  Brak dwukierunkowej synchronizacji.

- **System powiadomień**  
  Kanały e-mail / push (w MVP ograniczone lub wyłączone).


## 4. Pakiety przypadków użycia (wg domen)


## 4.1 Uwierzytelnianie i role (MVP — IN)

### Use Cases
- **UC-AUTH-01: Zalogować się przez SSO**
- **UC-AUTH-02: Automatycznie przypisać rolę użytkownika**
- **UC-AUTH-03: Zarządzać rolami użytkowników** (Admin)

> Brak lokalnych kont i haseł.


## 4.2 Aktualności i treści informacyjne (MVP — IN)

### Use Cases
- **UC-ANN-01: Przeglądać aktualności**
- **UC-ANN-02: Filtrować aktualności**
- **UC-ANN-03: Wyświetlić szczegóły aktualności**
- **UC-ANN-04: Publikować aktualności** (Organizator)
- **UC-ANN-05: Moderować treści** (Admin)

> Moduł **read-only** dla Studentów w MVP.


## 4.3 Wydarzenia — odkrywanie (MVP — IN)

### Use Cases
- **UC-EVT-01: Przeglądać wydarzenia**
- **UC-EVT-02: Wyszukiwać i filtrować wydarzenia**
- **UC-EVT-03: Wyświetlić szczegóły wydarzenia**
- **UC-EVT-04: Sprawdzić informacje o dostępności wydarzenia**

> To są Use Cases **odkrywania i oceny**, bez zmiany stanu użytkownika.


## 4.4 Wydarzenia — zapisy i wejściówki (MVP — IN)

### Use Cases
- **UC-EVT-05: Zapisać się na wydarzenie**
- **UC-EVT-06: Zrezygnować z udziału w wydarzeniu**
- **UC-EVT-07: Uzyskać wejściówkę QR**
- **UC-EVT-08: Wyświetlić wejściówkę QR**
- **UC-EVT-09: Zweryfikować wejściówkę QR** (Organizator)

> To **jedyny obszar write-enabled dla Studenta w MVP**.


## 4.5 Feedback po wydarzeniu (MVP — IN)

### Use Cases
- **UC-EVT-14: Przesłać feedback po wydarzeniu** (Student)
- **UC-EVT-15: Wyświetlić własny feedback** (Student)

> Feedback jest dostępny tylko dla uczestników z potwierdzoną obecnością
> (scan QR) i tylko po zakończeniu wydarzenia.

---

## 4.6 Zarządzanie wydarzeniami (MVP — IN)

### Use Cases
- **UC-EVT-10: Utworzyć wydarzenie** (Organizator)
- **UC-EVT-11: Edytować wydarzenie** (Organizator)
- **UC-EVT-12: Opublikować wydarzenie** (Organizator)
- **UC-EVT-13: Zarządzać zapisami i listą uczestników** (Organizator)


## 4.7 Administracja merytoryczna (MVP — IN)

### Use Cases
- **UC-ADM-01: Zarządzać użytkownikami**
- **UC-ADM-02: Zarządzać strukturą jednostek**
- **UC-ADM-03: Moderować treści globalnie**
- **UC-ADM-04: Konfigurować zasady publikacji**


## 4.8 Mapy kampusu i nawigacja (MMF — OUT of MVP)

### Use Cases (odroczone)
- Wyświetlić mapę kampusu
- Wyszukać lokalizację
- Wyznaczyć trasę
- Wyznaczyć trasę dostępną

> Funkcjonalność **poza MVP**, zależna od danych CENAGIS / GiK.


## 4.9 Integracja z USOS (MMF — OUT of MVP)

### Use Cases (read-only)
- Wyświetlić przypomnienia z USOS
- Wyświetlić informacje o terminach

> Brak:
- synchronizacji dwukierunkowej,
- edycji danych,
- krytycznych zależności dla MVP.


## 4.10 Powiadomienia (MMF — OUT of MVP)

### Use Cases (odroczone)
- Otrzymać powiadomienie push
- Zarządzać preferencjami powiadomień
- Przeglądać historię powiadomień


## 5. Relacje między przypadkami użycia

### Include (obowiązkowe kroki)

- **UC-EVT-05 (Zapisać się na wydarzenie)**  
  `include` → **UC-AUTH-01 (Zalogować się przez SSO)**

- **UC-EVT-05**  
  `include` → **UC-EVT-07 (Uzyskać wejściówkę QR)**

- **UC-EVT-10 (Utworzyć wydarzenie)**  
  `include` → **UC-AUTH-01**


### Extend (warianty / rozszerzenia)

- **UC-EVT-02 (Filtrować wydarzenia)**  
  `extend` → **UC-EVT-01 (Przeglądać wydarzenia)**

- **UC-ANN-02 (Filtrować aktualności)**  
  `extend` → **UC-ANN-01 (Przeglądać aktualności)**

- **UC-EVT-04 (Sprawdzić dostępność)**  
  `extend` → **UC-EVT-03 (Szczegóły wydarzenia)**


## 6. Przypisanie aktorów do pakietów (skrót)

### Student
- Aktualności i wydarzenia (read-only).
- Zapisy na wydarzenia i wejściówki QR.
- (Po MVP) mapy, USOS, powiadomienia.

### Organizator / Pracownik jednostki
- Tworzenie i publikacja wydarzeń.
- Zarządzanie zapisami.
- Weryfikacja wejściówek QR.

### Administrator merytoryczny
- Role, struktura jednostek.
- Moderacja treści.
- Zasady publikacji i porządek systemowy.


## 7. Relacja do innych artefaktów

- **Use Cases** → opisują zachowanie systemu.
- **HTA** → opisuje pracę użytkownika (jak).
- **User Stories** → opisują wartość (po co).
- **AC / BDD** → weryfikują poprawność zachowania.

Brak Use Case = **świadomy Non-Goal**, nie luka analizy.


## 8. Pliki powiązane

- Diagram Use Case (PlantUML): `docs/diagrams/use_case.puml`
- Specyfikacja funkcjonalna: `docs/specs.md`
- User Stories: `docs/user-stories.md`
- HTA: `docs/analysis/task_analysis.md`
- MVP / MMF: `docs/mvp-mmf.md`
