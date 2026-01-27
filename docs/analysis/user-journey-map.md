# User Journey Map — PW_hub

## Cel i zakres

Celem dokumentu jest opisanie **kluczowych ścieżek użytkownika (User Journey Maps)** dla systemu PW_hub, w celu:

- lepszego planowania rozwoju funkcjonalnego,
- wsparcia testów i walidacji UX,
- ułatwienia komunikacji między zespołami technicznymi i produktowymi.

Zakres obejmuje role zdefiniowane w specyfikacji funkcjonalnej:

- **Student** — aplikacja mobilna (Flutter),
- **Organizator / Pracownik jednostki** — panel webowy (Django DTL).  

Dokument **nie zastępuje** specyfikacji funkcjonalnej — opisuje doświadczenie użytkownika w czasie.

---

## Założenia i ograniczenia

- Mapa odzwierciedla **wyłącznie funkcjonalności opisane w specyfikacji**.
- Dokument **nie projektuje nowych funkcji ani procesów**.
- Zachowania nieopisane w specyfikacji są oznaczane jako **ASSUMPTION** (brak takich w obecnej wersji).

---

## Persona / rola 1: Student (aplikacja mobilna Flutter)

**Cel użytkownika (JTBD):**
> *Chcę szybko znaleźć interesujące wydarzenie, zapisać się na nie i bezproblemowo dostać się na miejsce.*

Cel wynika z funkcjonalności: aktualności, wydarzenia, zapisy, wejściówki QR.  

### Mapa podróży — Student (etapy w kolumnach)

| **Warstwa / Etap**        | **1.&nbsp;Wejście do aplikacji**                  | **2.&nbsp;Orientacja i aktualności**              | **3.&nbsp;Odkrywanie wydarzeń**                     | **4.&nbsp;Ocena szczegółów**                      | **5.&nbsp;Zapis na wydarzenie**    | **6.&nbsp;Udział i wejście**          |
|---------------------------|---------------------------------------------------|---------------------------------------------------|-----------------------------------------------------|---------------------------------------------------|------------------------------------|---------------------------------------|
| **Działania użytkownika** | Otwiera aplikację i loguje się kontem uczelnianym | Przegląda aktualności, filtruje treści            | Przegląda listę/kalendarz wydarzeń                  | Sprawdza opis, lokalizację, dostępność            | Zapisuje się lub rezygnuje         | Wyświetla wejściówkę QR przy wejściu  |
| **Główne touchpointy**    | Logowanie SSO                                     | Lista aktualności                                 | Lista + kalendarz wydarzeń                          | Szczegóły wydarzenia                              | Moduł zapisów                      | Wejściówki QR                         |
| **Oczekiwania / emocje**  | 😐 szybki dostęp bez zakładania konta             | 😐 szybka orientacja, co jest ważne               | 🙂 łatwe znalezienie czegoś dla siebie              | 😐 świadoma decyzja                               | 🙂 jasny status zapisu             | 🙂 pewność wejścia                    |
| **Pain points**           | Złożone logowanie, brak przypisania roli          | Nadmiar treści, brak filtrów                      | Trudno ocenić istotność wydarzenia                  | Brak info o dostępności lub miejscu               | Brak miejsc, niejasny status       | Brak dostępu offline, nieczytelny kod |
| **Implikacje produktowe** | SSO, brak lokalnych haseł, auto-przypisanie roli  | Filtry, oznaczanie przeczytanych, wersje językowe | Filtry (kategoria, język, dostępność), wyszukiwanie | Pełne dane: opis, termin, lokalizacja, dostępność | Limity miejsc, jednoznaczny status | Unikalny QR, dostęp offline           |

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

## Zidentyfikowane luki i pytania otwarte

- Brak zdefiniowanej ścieżki **feedbacku po wydarzeniu** w specyfikacji — nieujęte w mapie.
- Brak przypisania **powiadomień push** do konkretnych etapów podróży (opisane ogólnie).【F:docs/specs.md†L35-L42】

---

## Potencjalne kolejne kroki

- Rozszerzenie dokumentu o **User Journey Map dla administratora merytorycznego** (jeśli jego scenariusze staną się
  istotne).
- Zdefiniowanie **metryk sukcesu** (np. czas zapisu, skuteczność weryfikacji QR) jako wejście do testów i dalszego
  planowania produktu.
