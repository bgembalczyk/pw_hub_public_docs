# WCAG 2.1 AA — panel administratora merytorycznego (kontrakt dostępności)

## 0. Metadane dokumentu
- **Cel:** doprecyzowanie wymagań WCAG 2.1 poziom AA dla panelu administratora merytorycznego, w formie audytowalnego kontraktu jakościowego.
- **Zakres systemowy:** wyłącznie **panel administratora merytorycznego** (Django DTL, dedykowany panel), bez aplikacji mobilnej i bez panelu jednostek/organizatorów.
- **Status:** obowiązujący kontrakt jakościowy dla panelu.
- **Źródła prawdy:**
  - `docs/specs.md` (opis panelu administratora merytorycznego i deklaracja WCAG 2.1). 
  - `docs/analysis/acceptance-criteria-analysis.md` (AC-2: WCAG 2.1 AA).
  - `docs/mock_django/admin_panel/` (mock-upy panelu).
- **Odbiorcy:** Product, UX, Frontend/Template, QA.

---

## 1. Zakres dostępności WCAG
1. **Zakres standardu:** WCAG 2.1 **poziom AA**.
2. **Zakres produktu:** wyłącznie panel administratora merytorycznego (web/Django DTL).
3. **Wyłączenia:** aplikacja mobilna Flutter, panel jednostek/organizatorów, inne panele i strony publiczne.
4. **Definicja zgodności:** panel spełnia wszystkie **kryteria sukcesu WCAG 2.1 poziom A i AA**. Kryteria nieistotne muszą być jawnie wskazane i uzasadnione (poniżej).

---

## 2. Pełna lista kryteriów WCAG 2.1 AA (zastosowanie do panelu)

Legenda:
- **Zastosowanie:** TAK / NIE (z uzasadnieniem)
- **Praktyka:** krótki opis, co oznacza kryterium w panelu
- **Dotyczy panelu:** elementy UI/obszary

### 1. Postrzegalność (Perceivable)
- **1.1.1 Treść nietekstowa (A)** — **Zastosowanie: TAK**. 
  - **Praktyka:** każda ikona/funkcyjny obraz ma tekst alternatywny lub etykietę ARIA.
  - **Dotyczy panelu:** ikony akcji w tabelach, przyciski z ikonami, grafiki w dashboardzie.

- **1.2.1 Tylko audio / tylko wideo (A)** — **Zastosowanie: NIE**. 
  - **Uzasadnienie:** panel nie zawiera treści audio/wideo.

- **1.2.2 Napisy (nagrania) (A)** — **Zastosowanie: NIE**. 
  - **Uzasadnienie:** panel nie zawiera wideo z dźwiękiem.

- **1.2.3 Audiodeskrypcja lub alternatywa (nagrania) (A)** — **Zastosowanie: NIE**. 
  - **Uzasadnienie:** brak treści wideo.

- **1.2.4 Napisy (na żywo) (AA)** — **Zastosowanie: NIE**. 
  - **Uzasadnienie:** brak streamingu live.

- **1.2.5 Audiodeskrypcja (nagrania) (AA)** — **Zastosowanie: NIE**. 
  - **Uzasadnienie:** brak treści wideo.

- **1.3.1 Informacje i relacje (A)** — **Zastosowanie: TAK**. 
  - **Praktyka:** semantyczne nagłówki, etykiety pól, grupy i tabelaryczne relacje są odzwierciedlone w HTML/ARIA.
  - **Dotyczy panelu:** formularze moderacji, tabele list, filtry, sekcje dashboardu.

- **1.3.2 Znacząca kolejność (A)** — **Zastosowanie: TAK**. 
  - **Praktyka:** kolejność DOM i fokus odpowiada logicznej kolejności czytania.
  - **Dotyczy panelu:** formularze wielosekcyjne, tabele, modalne potwierdzenia.

- **1.3.3 Właściwości sensoryczne (A)** — **Zastosowanie: TAK**. 
  - **Praktyka:** instrukcje nie opierają się wyłącznie na kolorze/położeniu (np. „na czerwono po lewej”).
  - **Dotyczy panelu:** komunikaty walidacji, opisy akcji w moderacji.

- **1.3.4 Orientacja (AA)** — **Zastosowanie: TAK**. 
  - **Praktyka:** brak blokady orientacji ekranu; treść dostępna w pionie i poziomie.
  - **Dotyczy panelu:** cały panel w przeglądarce.

- **1.3.5 Określenie celu pól (AA)** — **Zastosowanie: TAK**. 
  - **Praktyka:** pola danych użytkownika mają poprawne `autocomplete`/etykiety.
  - **Dotyczy panelu:** formularze użytkowników, ról, jednostek.

- **1.4.1 Użycie koloru (A)** — **Zastosowanie: TAK**. 
  - **Praktyka:** informacja nie jest przekazywana wyłącznie kolorem.
  - **Dotyczy panelu:** statusy moderacji, walidacja pól, badge'e w tabelach.

- **1.4.2 Kontrola dźwięku (A)** — **Zastosowanie: NIE**. 
  - **Uzasadnienie:** panel nie generuje dźwięku automatycznie.

- **1.4.3 Kontrast (minimum) (AA)** — **Zastosowanie: TAK**. 
  - **Praktyka:** tekst/ikonografia ma kontrast min. 4.5:1 (3:1 dla dużego tekstu).
  - **Dotyczy panelu:** wszystkie widoki panelu, szczególnie tabele i przyciski.

- **1.4.4 Zmiana rozmiaru tekstu (AA)** — **Zastosowanie: TAK**. 
  - **Praktyka:** do 200% bez utraty treści/funkcji.
  - **Dotyczy panelu:** layouty list i formularzy.

- **1.4.5 Obrazy tekstu (AA)** — **Zastosowanie: TAK**. 
  - **Praktyka:** nie używać tekstu jako obrazu, poza logotypami.
  - **Dotyczy panelu:** nagłówki, przyciski, etykiety.

- **1.4.10 Reflow (AA)** — **Zastosowanie: TAK**. 
  - **Praktyka:** treść reflow do 320 CSS px bez poziomego scrolla (poza tabelami, gdzie dopuszczony).
  - **Dotyczy panelu:** widoki tabel, formularze, dashboard.

- **1.4.11 Kontrast elementów nietekstowych (AA)** — **Zastosowanie: TAK**. 
  - **Praktyka:** granice pól, focus, ikony mają kontrast min. 3:1.
  - **Dotyczy panelu:** pola formularzy, przyciski ikonowe, fokus.

- **1.4.12 Odstępy w tekście (AA)** — **Zastosowanie: TAK**. 
  - **Praktyka:** po zwiększeniu odstępów (line-height/spacing) treść pozostaje czytelna.
  - **Dotyczy panelu:** wszystkie teksty i opisy.

- **1.4.13 Treść po najechaniu lub fokusu (AA)** — **Zastosowanie: TAK**. 
  - **Praktyka:** tooltips/popover można utrzymać na ekranie, zamknąć i są dostępne klawiaturą.
  - **Dotyczy panelu:** podpowiedzi ikon akcji, skrócone opisy.

### 2. Funkcjonalność (Operable)
- **2.1.1 Klawiatura (A)** — **Zastosowanie: TAK**. 
  - **Praktyka:** wszystkie funkcje dostępne z klawiatury.
  - **Dotyczy panelu:** nawigacja, tabele, formularze, akcje moderacji.

- **2.1.2 Brak pułapki klawiaturowej (A)** — **Zastosowanie: TAK**. 
  - **Praktyka:** fokus da się przenieść z każdego komponentu.
  - **Dotyczy panelu:** modale, selecty, filtry.

- **2.1.4 Skróty klawiszowe (A)** — **Zastosowanie: TAK**. 
  - **Praktyka:** skróty jednoklawiszowe można wyłączyć lub wymagają modyfikatora.
  - **Dotyczy panelu:** ewentualne skróty w tabelach/edytorach.

- **2.2.1 Dostosowanie limitu czasu (A)** — **Zastosowanie: TAK**. 
  - **Praktyka:** sesja wygasająca informuje i pozwala przedłużyć czas.
  - **Dotyczy panelu:** logowanie i sesje administratora.

- **2.2.2 Pauza, zatrzymanie, ukrycie (A)** — **Zastosowanie: TAK**. 
  - **Praktyka:** auto-odświeżanie/animacje można zatrzymać.
  - **Dotyczy panelu:** dashboard z odświeżaniem, powiadomienia.

- **2.3.1 Trzy błyski lub poniżej progu (A)** — **Zastosowanie: TAK**. 
  - **Praktyka:** brak migających elementów przekraczających próg.
  - **Dotyczy panelu:** komunikaty i alerty.

- **2.4.1 Ominięcie bloków (A)** — **Zastosowanie: TAK**. 
  - **Praktyka:** „Przejdź do treści” lub równoważny mechanizm.
  - **Dotyczy panelu:** stała nawigacja i sidebar.

- **2.4.2 Tytuł strony (A)** — **Zastosowanie: TAK**. 
  - **Praktyka:** unikalny i opisowy tytuł każdej strony.
  - **Dotyczy panelu:** wszystkie widoki.

- **2.4.3 Kolejność fokusu (A)** — **Zastosowanie: TAK**. 
  - **Praktyka:** fokus przebiega logicznie.
  - **Dotyczy panelu:** formularze i tabele.

- **2.4.4 Cel łącza (w kontekście) (A)** — **Zastosowanie: TAK**. 
  - **Praktyka:** link opisuje cel sam lub w kontekście.
  - **Dotyczy panelu:** linki w listach i nawigacji.

- **2.4.5 Wiele sposobów (AA)** — **Zastosowanie: TAK**. 
  - **Praktyka:** co najmniej dwa sposoby dotarcia do treści (np. menu + wyszukiwarka/filtry).
  - **Dotyczy panelu:** listy treści, użytkowników, jednostek.

- **2.4.6 Nagłówki i etykiety (AA)** — **Zastosowanie: TAK**. 
  - **Praktyka:** nagłówki/etykiety opisują temat i cel.
  - **Dotyczy panelu:** formularze, sekcje dashboardu.

- **2.4.7 Widoczny fokus (AA)** — **Zastosowanie: TAK**. 
  - **Praktyka:** wyraźny fokus na elementach interaktywnych.
  - **Dotyczy panelu:** wszystkie kontrolki.

- **2.5.1 Gesty wskaźnika (A)** — **Zastosowanie: TAK**. 
  - **Praktyka:** akcje nie wymagają gestów złożonych (np. tylko przeciągnięcie).
  - **Dotyczy panelu:** sortowanie, reorder, interakcje w tabelach.

- **2.5.2 Anulowanie wskaźnika (A)** — **Zastosowanie: TAK**. 
  - **Praktyka:** kliknięcia można anulować (np. brak natychmiastowego wykonania przy `mousedown`).
  - **Dotyczy panelu:** przyciski akcji, elementy list.

- **2.5.3 Etykieta w nazwie (A)** — **Zastosowanie: TAK**. 
  - **Praktyka:** tekst widocznej etykiety jest zawarty w dostępnej nazwie.
  - **Dotyczy panelu:** przyciski, linki, pola.

- **2.5.4 Aktywacja ruchem (A)** — **Zastosowanie: TAK**. 
  - **Praktyka:** funkcje nie wymagają potrząsania/pochylania urządzenia.
  - **Dotyczy panelu:** cały panel.

### 3. Zrozumiałość (Understandable)
- **3.1.1 Język strony (A)** — **Zastosowanie: TAK**. 
  - **Praktyka:** ustawiony `lang` dla całej strony.
  - **Dotyczy panelu:** wszystkie widoki.

- **3.1.2 Język części (AA)** — **Zastosowanie: TAK**. 
  - **Praktyka:** fragmenty w innym języku mają poprawny `lang`.
  - **Dotyczy panelu:** treści mieszane PL/EN (np. nazwy własne).

- **3.2.1 Zmiana przy fokusie (A)** — **Zastosowanie: TAK**. 
  - **Praktyka:** fokus nie wywołuje niespodziewanej zmiany kontekstu.
  - **Dotyczy panelu:** selecty, menu.

- **3.2.2 Zmiana przy wprowadzaniu (A)** — **Zastosowanie: TAK**. 
  - **Praktyka:** zmiany kontekstu po input wymagają potwierdzenia.
  - **Dotyczy panelu:** filtry i formularze.

- **3.2.3 Spójna nawigacja (AA)** — **Zastosowanie: TAK**. 
  - **Praktyka:** menu w tej samej kolejności na wszystkich stronach.
  - **Dotyczy panelu:** sidebar/topbar.

- **3.2.4 Spójna identyfikacja (AA)** — **Zastosowanie: TAK**. 
  - **Praktyka:** te same akcje mają spójne nazwy i ikony.
  - **Dotyczy panelu:** przyciski akcji w listach i formularzach.

- **3.3.1 Identyfikacja błędu (A)** — **Zastosowanie: TAK**. 
  - **Praktyka:** błąd jest jednoznacznie wskazany i opisany.
  - **Dotyczy panelu:** walidacja formularzy.

- **3.3.2 Etykiety lub instrukcje (A)** — **Zastosowanie: TAK**. 
  - **Praktyka:** pola mają etykiety i wymagania są opisane.
  - **Dotyczy panelu:** formularze moderacji, użytkowników, integracji.

- **3.3.3 Sugestia korekty błędu (AA)** — **Zastosowanie: TAK**. 
  - **Praktyka:** komunikaty błędów zawierają wskazówki naprawy.
  - **Dotyczy panelu:** formularze i akcje masowe.

- **3.3.4 Zapobieganie błędom (prawne/finansowe/dane) (AA)** — **Zastosowanie: TAK**. 
  - **Praktyka:** potwierdzenia dla nieodwracalnych akcji; możliwość cofnięcia.
  - **Dotyczy panelu:** publikacja/odrzucenie, usunięcia, zmiany ról.

### 4. Solidność (Robust)
- **4.1.1 Poprawność kodu (A)** — **Zastosowanie: TAK**. 
  - **Praktyka:** poprawny HTML bez krytycznych błędów parsowania.
  - **Dotyczy panelu:** wszystkie widoki.

- **4.1.2 Nazwa, rola, wartość (A)** — **Zastosowanie: TAK**. 
  - **Praktyka:** komponenty niestandardowe mają właściwe role i stany.
  - **Dotyczy panelu:** custom selecty, modale, przyciski ikonowe.

- **4.1.3 Komunikaty o statusie (AA)** — **Zastosowanie: TAK**. 
  - **Praktyka:** statusy (sukces/błąd) są ogłaszane bez zmiany fokusu.
  - **Dotyczy panelu:** toast/alert po moderacji, zapisie, usunięciu.

---

## 3. Mapowanie kryteriów na komponenty panelu

| Komponent panelu | Opis | Kryteria WCAG (A/AA) |
| --- | --- | --- |
| Nawigacja globalna (sidebar/topbar) | Stałe menu i skróty do sekcji | 2.4.1, 2.4.2, 2.4.3, 2.4.5, 2.4.6, 2.4.7, 3.2.3 |
| Dashboard/statystyki | Widok startowy, KPI, wykresy | 1.1.1, 1.3.1, 1.3.2, 1.4.3, 1.4.11, 1.4.13, 2.2.2 |
| Tabele/listy treści | Listy aktualności, wydarzeń, użytkowników | 1.3.1, 1.3.2, 1.4.3, 2.1.1, 2.4.3, 2.4.4, 2.5.1, 3.2.4 |
| Filtry/sortowanie/wyszukiwarka | Sterowanie listami | 1.3.1, 1.3.3, 2.1.1, 3.2.2, 3.3.2 |
| Formularze CRUD | Tworzenie/edycja treści, użytkowników | 1.3.1, 1.3.2, 1.3.5, 1.4.1, 1.4.3, 2.4.6, 3.3.1, 3.3.2, 3.3.3, 3.3.4 |
| Moderacja treści | Akceptuj/odrzuć/komentarz | 2.1.1, 2.4.4, 3.3.4, 4.1.3 |
| Zarządzanie rolami i uprawnieniami | Zmiany ról, stany krytyczne | 1.3.1, 2.4.6, 3.3.4 |
| Dialogi i modale | Potwierdzenia i ostrzeżenia | 2.1.2, 2.4.3, 2.4.7, 4.1.2, 4.1.3 |
| Powiadomienia/alerty/toasty | Informacje o wyniku akcji | 1.4.1, 4.1.3 |
| Logowanie i sesja | Ekran logowania, timeouty | 2.2.1, 3.1.1, 3.3.1 |

---

## 4. Checklisty WCAG

### 4.1 Checklist dla code review / implementacji (TAK/NIE)
- [ ] Każdy element interaktywny jest dostępny z klawiatury (2.1.1).
- [ ] Fokus jest widoczny i logiczny w całym panelu (2.4.3, 2.4.7).
- [ ] Formularze mają poprawne etykiety, wymagania i komunikaty błędów (1.3.1, 3.3.1, 3.3.2).
- [ ] Linki/przyciski mają jednoznaczne nazwy i opisy (2.4.4, 2.5.3).
- [ ] Kontrast tekstu i kontrolek spełnia minimum (1.4.3, 1.4.11).
- [ ] Widoki działają przy powiększeniu 200% i reflow (1.4.4, 1.4.10).
- [ ] Tooltipy/elementy po hover/focus są dostępne i możliwe do zamknięcia (1.4.13).
- [ ] Modale i komponenty niestandardowe mają prawidłowe role/ARIA (4.1.2).
- [ ] Komunikaty statusu są ogłaszane bez zmiany fokusu (4.1.3).
- [ ] Instrukcje nie polegają wyłącznie na kolorze lub położeniu (1.3.3, 1.4.1).

### 4.2 Checklist dla testów QA (TAK/NIE)
- [ ] Panel można w pełni obsłużyć wyłącznie klawiaturą (2.1.1, 2.1.2).
- [ ] Kolejność fokusu jest spójna w kluczowych ścieżkach (2.4.3).
- [ ] Wszystkie akcje krytyczne wymagają potwierdzenia lub umożliwiają cofnięcie (3.3.4).
- [ ] Komunikaty błędów wskazują pole i sugerują poprawę (3.3.1, 3.3.3).
- [ ] Etykiety pól są czytane przez screen reader (1.3.1, 3.3.2).
- [ ] Kontrast tekstu/ikon i stanów fokus spełnia minimum (1.4.3, 1.4.11).
- [ ] Tytuły stron są opisowe i unikalne (2.4.2).
- [ ] W menu istnieją co najmniej dwa sposoby dotarcia do kluczowych treści (2.4.5).
- [ ] Komunikaty o statusie są ogłaszane bez przenoszenia fokusu (4.1.3).
- [ ] Brak nieoczekiwanych zmian kontekstu po fokusie/zmianie pola (3.2.1, 3.2.2).

---

## 5. Plan audytu dostępności

### 5.1 Audyt manualny (obowiązkowy)
1. **Klawiatura:** przejście całego panelu (tab/shift+tab/enter/space/esc).
2. **Fokus:** widoczność i logiczna kolejność w tabelach, formularzach i modalach.
3. **Czytelność/kontrast:** weryfikacja kontrastów i stanów fokusu.
4. **Screen reader (ogólnie):** odczyt etykiet, nagłówków, komunikatów statusu.
5. **Reflow i powiększenie:** 200% oraz 320 CSS px (brak utraty funkcji).

### 5.2 Audyt automatyczny (obowiązkowy)
- **Klasy narzędzi:**
  - linters/analizatory dostępności HTML,
  - testy automatyczne w przeglądarce (a11y),
  - walidatory kontrastu.
- **Zakres wykrywalności:**
  - wykrywa: brak alt/label, niepoprawne ARIA, błędy semantyki, kontrast.
  - nie wykrywa: logicznej kolejności fokusu, pełnej używalności klawiaturą, zrozumiałości komunikatów.

---

## 6. Minimalne kryteria DONE (WCAG 2.1 AA)
Panel administratora merytorycznego jest uznany za zgodny z WCAG 2.1 AA wyłącznie gdy:
1. **Checklista implementacyjna i QA** są w całości zaliczone.
2. **Brak krytycznych naruszeń** WCAG 2.1 A/AA w kluczowych ścieżkach panelu.
3. **Udokumentowany audyt** (manualny + automatyczny) jest załączony do wydania.
4. **Kryteria nieistotne** mają uzasadnienie (sekcja 2).

---

## 7. Plan testów dostępności (REQUIRED OUTPUT)

### 7.1 Scenariusze manualne (Given / When / Then)
1. **Nawigacja klawiaturą**
   - **Given** użytkownik jest zalogowany do panelu,
   - **When** porusza się po panelu wyłącznie klawiaturą,
   - **Then** wszystkie funkcje są dostępne bez pułapek fokusowych.

2. **Moderacja treści**
   - **Given** lista treści do moderacji,
   - **When** użytkownik przechodzi do szczegółów i zatwierdza/odrzuca wpis,
   - **Then** akcja jest możliwa z klawiatury i potwierdzona czytelnym komunikatem.

3. **Walidacja formularza**
   - **Given** formularz edycji treści,
   - **When** użytkownik zostawi pole wymagane puste,
   - **Then** pojawia się komunikat błędu przypisany do pola i z sugestią poprawy.

4. **Dialog potwierdzenia**
   - **Given** akcja krytyczna (np. usunięcie),
   - **When** pojawia się modal potwierdzenia,
   - **Then** fokus zostaje przeniesiony do modala i można go zamknąć klawiaturą.

5. **Powiększenie i reflow**
   - **Given** widok tabeli,
   - **When** powiększenie wynosi 200% lub szerokość 320 CSS px,
   - **Then** treść pozostaje dostępna bez utraty funkcji (poziomy scroll tylko w tabeli).

### 7.2 Kryteria sprawdzane automatycznie
- 1.1.1, 1.3.1, 1.4.3, 1.4.11, 2.4.2, 3.1.1, 4.1.1, 4.1.2, 4.1.3.

### 7.3 Raportowanie wyników audytu
- Raport zawiera:
  - listę naruszeń z mapowaniem do kryteriów WCAG,
  - status: **zaliczone / niezaliczone / nieistotne (z uzasadnieniem)**,
  - dowody: zrzuty ekranu, logi z narzędzi automatycznych,
  - decyzje o akceptacji ryzyk (jeśli wystąpiły).

---

## 8. Ryzyka i ich eliminacja
- **Ryzyko: formalna niezgodność z WCAG mimo deklaracji.**
  - **Eliminacja:** sekcja 2 (pełna lista kryteriów + zastosowanie) oraz kryteria DONE w sekcji 6.
- **Ryzyko: brak spójnego podejścia QA do dostępności.**
  - **Eliminacja:** checklisty QA (sekcja 4.2) + plan audytu (sekcja 5).
- **Ryzyko: „checkbox compliance” bez realnej testowalności.**
  - **Eliminacja:** scenariusze Given/When/Then (sekcja 7.1) + obowiązkowy audyt manualny.
