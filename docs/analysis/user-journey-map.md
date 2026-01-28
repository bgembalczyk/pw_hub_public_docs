# User Journey Map — PW_hub

## Cel i zakres

Celem dokumentu jest opisanie **kluczowych ścieżek użytkownika (User Journey Maps)** dla systemu PW_hub, w celu:

- lepszego planowania rozwoju funkcjonalnego,
- wsparcia testów i walidacji UX,
- ułatwienia komunikacji między zespołami technicznymi i produktowymi.

Zakres obejmuje role zdefiniowane w specyfikacji funkcjonalnej:

- **Student** — aplikacja mobilna (Flutter),
- **Organizator / Pracownik jednostki** — panel webowy (Django DTL),
- **Administrator merytoryczny** — panel webowy (Django DTL).

Dokument **nie zastępuje** specyfikacji funkcjonalnej — opisuje doświadczenie użytkownika w czasie.

---

## Założenia i ograniczenia

- Mapa odzwierciedla **funkcjonalności opisane w specyfikacji** oraz zaplanowane rozszerzenia,
  jeśli mają dedykowany issue w repozytorium.
- Dokument **nie projektuje nowych funkcji ani procesów** bez wskazanego źródła (issue/ADR).
- Zachowania nieopisane w specyfikacji są oznaczane jako **ASSUMPTION**.

---

## Persona / rola 1: Student (aplikacja mobilna Flutter)

**Cel użytkownika (JTBD):**
> *Chcę szybko znaleźć interesujące wydarzenie, zapisać się na nie i bezproblemowo dostać się na miejsce.*

Cel wynika z funkcjonalności: aktualności, wydarzenia, zapisy, wejściówki QR.

**Nota zakresu (P1 — kalendarz wydarzeń):** Issue dotyczące kalendarza wydarzeń obejmuje etapy
**3–4 (Odkrywanie wydarzeń → Ocena szczegółów)** i wyłącza zapisy/wejściówki z zakresu prac.

### Mapa podróży — Student (etapy w kolumnach)

| **Warstwa / Etap**        | **1.&nbsp;Onboarding profilu**                                 | **2.&nbsp;Wejście do aplikacji**                  | **3.&nbsp;Orientacja i aktualności**              | **4.&nbsp;Odkrywanie wydarzeń**                                                               | **5.&nbsp;Ocena szczegółów**                     | **6.&nbsp;Zapis na wydarzenie**    | **7.&nbsp;Udział i wejście**          | **8.&nbsp;Feedback po wydarzeniu**                                  |
|---------------------------|----------------------------------------------------------------|---------------------------------------------------|---------------------------------------------------|-----------------------------------------------------------------------------------------------|--------------------------------------------------|------------------------------------|---------------------------------------|---------------------------------------------------------------------|
| **Działania użytkownika** | Wybiera wydział, rok, opcjonalnie grupę                        | Otwiera aplikację i loguje się kontem uczelnianym | Przegląda aktualności, filtruje treści            | Przegląda listę wydarzeń, stosuje filtry i zakres dat                                         | Sprawdza opis, datę, lokalizację, organizatora   | Zapisuje się lub rezygnuje         | Wyświetla wejściówkę QR przy wejściu  | Ocenia wydarzenie i wysyła opinię                                   |
| **Główne touchpointy**    | Krótki onboarding profilu                                      | Logowanie SSO                                     | Lista aktualności                                 | Lista wydarzeń + filtry (wydział/kategoria/data) + licznik wyników                            | Szczegóły wydarzenia                             | Moduł zapisów                      | Wejściówki QR                         | Ekran feedbacku + powiadomienie push                                |
| **Oczekiwania / emocje**  | 😐 szybkie uzupełnienie, bez zbędnych pytań                    | 😐 szybki dostęp bez zakładania konta             | 😐 szybka orientacja, co jest ważne               | 🙂 łatwe znalezienie czegoś dla siebie                                                        | 😐 świadoma decyzja                              | 🙂 jasny status zapisu             | 🙂 pewność wejścia                    | 🙂 krótki, prosty feedback                                          |
| **Pain points**           | Za dużo kroków, niepełne słowniki, brak opcji pominięcia grupy | Złożone logowanie, brak przypisania roli          | Nadmiar treści, brak filtrów                      | Trudno ocenić istotność wydarzenia                                                            | Brak info o dostępności lub miejscu              | Brak miejsc, niejasny status       | Brak dostępu offline, nieczytelny kod | Brak czasu, niejasne pytania                                        |
| **Implikacje produktowe** | Minimalny zakres pól, opcja „pomiń” dla grupy                  | SSO, brak lokalnych haseł, auto-przypisanie roli  | Filtry, oznaczanie przeczytanych, wersje językowe | Filtry (wydział, kategoria, data), licznik wyników, stan pusty + reset filtrów, loading/error | Pełne dane: opis, data, lokalizacja, organizator | Limity miejsc, jednoznaczny status | Unikalny QR, dostęp offline           | Krótki formularz 1–3 pytania, dostępność, agregaty dla organizatora |

---

## Persona / rola 2: Organizator / Pracownik jednostki (panel Django)

**Cel użytkownika (JTBD):**
> *Chcę sprawnie opublikować wydarzenie, zarządzać zapisami i bezproblemowo zweryfikować uczestników.*

Cele wynikają z funkcji panelu jednostki.

### Mapa podróży — Organizator / Pracownik jednostki

| **Warstwa / Etap**        | **1.&nbsp;Logowanie do panelu** | **2.&nbsp;Tworzenie wydarzenia**  | **3.&nbsp;Zarządzanie zapisami**      | **4.&nbsp;Weryfikacja uczestników**          |
|---------------------------|---------------------------------|-----------------------------------|---------------------------------------|----------------------------------------------|
| **Działania użytkownika** | Loguje się do panelu jednostki  | Dodaje i publikuje wydarzenie     | Przegląda listę zapisów i uczestników | Skanuje / weryfikuje kod QR                  |
| **Główne touchpointy**    | Panel Django (DTL)              | Formularz wydarzeń                | Widok zapisów                         | Weryfikacja wejściówek                       |
| **Oczekiwania / emocje**  | 😐 stabilny, prosty panel       | 🙂 szybka publikacja              | 😐 kontrola nad listą                 | 🙂 jednoznaczna decyzja                      |
| **Pain points**           | Zbyt techniczny interfejs       | Nadmiar pól, brak walidacji       | Niejasne statusy                      | Błędy w weryfikacji, brak uprawnień          |
| **Implikacje produktowe** | Panel oparty o Django DTL       | Walidacja danych, edycja wydarzeń | Czytelna lista uczestników            | Weryfikacja QR tylko dla organizatora/staffu |

---

## Persona / rola 3: Administrator merytoryczny (panel Django)

**Kontekst roli i odpowiedzialności:**

- Zakres: treści i wydarzenia (moderacja, publikacja), struktura jednostek, role i uprawnienia.
- Relacje: współpraca z autorami/organizatorami, koordynacja z administratorem technicznym.
- Cele biznesowe: spójność i poprawność informacji, minimalizacja ryzyk reputacyjnych, aktualność treści.

### Mapa podróży — Administrator merytoryczny

| **Warstwa / Etap**                        | **1.&nbsp;Wejście i orientacja**             | **2.&nbsp;Triaging treści**                         | **3.&nbsp;Weryfikacja merytoryczna**                     | **4.&nbsp;Decyzja i publikacja**                             | **5.&nbsp;Nadzór i utrzymanie**                                   |
|-------------------------------------------|----------------------------------------------|-----------------------------------------------------|----------------------------------------------------------|--------------------------------------------------------------|-------------------------------------------------------------------|
| **Cele użytkownika**                      | Zrozumieć bieżącą sytuację (co wymaga uwagi) | Ustalić priorytet i kolejność pracy                 | Potwierdzić poprawność i kompletność                     | Podjąć jednoznaczną decyzję (zaakceptować/odrzucić/cofnąć)   | Utrzymać spójność, reagować na incydenty                          |
| **Działania użytkownika**                 | Loguje się, przegląda dashboard/statusy      | Otwiera kolejkę treści, filtruje po typie/jednostce | Sprawdza treść, termin, lokalizację, zgodność z polityką | Akceptuje/odrzuca/prosi o poprawę, publikuje/cofa publikację | Monitoruje zmiany, audytuje role, aktualizuje strukturę jednostek |
| **Główne touchpointy**                    | Panel admina (dashboard, alerty)             | Lista treści do moderacji                           | Widok szczegółów treści/wydarzeń                         | Workflow decyzji (statusy, komentarz)                        | Panel ról i jednostek, lista zdarzeń/aktywności                   |
| **Pain points / ryzyka**                  | Brak jasnych priorytetów i SLA               | Nadmiar treści, niejednolite dane                   | Niewystarczające informacje do decyzji                   | Ryzyko błędnej publikacji lub opóźnień                       | Konflikty uprawnień, brak historii decyzji                        |
| **Potrzeby informacyjne / decyzje**       | Jakie treści są krytyczne i „na już”?        | Czy treść jest kompletna i od kogo pochodzi?        | Czy dane są zgodne z polityką i prawdziwe?               | Jaki status i uzasadnienie decyzji?                          | Czy rola/uprawnienia są nadal aktualne?                           |
| **Edge-case’y / sytuacje niestandardowe** | Presja czasowa: publikacja „na już”          | Niekompletne dane od autora                         | Zmiana wydarzenia po zapisach użytkowników               | Cofnięcie publikacji i komunikat o wycofaniu                 | Konflikty uprawnień lub spór między jednostkami                   |

---

## Granice zakresu — Administrator merytoryczny

**MVP — IN:**

- Moderacja treści i wydarzeń (akceptacja/odrzucenie/prośba o poprawę).
- Zarządzanie rolami i strukturą jednostek.
- Zasady publikacji i kontrola statusów treści.

**MMF / później:**

- Raporty i statystyki skuteczności treści.
- Automatyczne reguły jakości/SLA (eskalacje, przypomnienia).
- Rozszerzony audyt i wersjonowanie treści.

**Non-goals:**

- Projektowanie UI i szczegółowych ekranów.
- Implementacja backendu i workflow engine.
- Personalizacja treści dla studentów lub rekomendacje.

---

## Zidentyfikowane luki i pytania otwarte

- Ścieżka **feedbacku po wydarzeniu** zdefiniowana w issue: [
  `docs/analysis/issues/feedback-post-event.md`](issues/feedback-post-event.md).
- Brak przypisania **powiadomień push** do konkretnych etapów podróży (opisane ogólnie).【F:docs/specs.md†L35-L42】
- Brak potwierdzenia **SLA moderacji** i zasad eskalacji dla administratora merytorycznego.

---

## ASSUMPTION / TODO

- **ASSUMPTION:** potrzeby raportowe i statystyczne administratora merytorycznego nie są kompletne.  
  **Weryfikacja:** warsztat discovery z BKiP + analiza obecnych raportów administracyjnych.
- **TODO:** potwierdzić SLA moderacji i zasady eskalacji (jeśli istnieją w organizacji).

---

## Potencjalne kolejne kroki

- Zdefiniowanie **metryk sukcesu** (np. czas zapisu, skuteczność weryfikacji QR) jako wejście do testów i dalszego
  planowania produktu.
