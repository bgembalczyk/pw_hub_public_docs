# System agentowy (PW_hub)

Ten katalog opisuje **jak działa system agentów** oraz gdzie znajdują się zasady, które należy dołączyć do kontekstu podczas pracy.

## Jak działa system

System jest **półautomatyczny** i orkiestruje go użytkownik:
- Użytkownik może jawnie wskazać agenta lub zasadę, np.:
  - „Wciel się w Software Artificer i zrób X”
  - „Użyj Creed of Form i …”
- Gdy wskazanie jest jawne: **odczytaj wskazany plik** z katalogu `agents_instructions/` i **dodaj jego treść do kontekstu** jako obowiązujące zasady zachowania.
- Gdy brak jawnego wskazania: **samodzielnie wybierz** odpowiednich agentów (roles/tech/principles), odczytaj ich pliki i dołącz zasady do kontekstu.

> Zasady z plików agentów traktujemy jako **kontrakt zachowania**, nie jako inspirację.

## Priorytety pracy

**Czas wykonania jest najmniej ważny.**
Najważniejsze są: **analiza, poprawność i kompletność**, uwzględniające zarówno treść zadania, jak i pozostałe wymagania z instrukcji agentów.

## Gdzie są reguły

Struktura katalogu `agents_instructions/`:
- `roles/` – role decyzyjne (perspektywy domenowe)
- `tech/` – agenci techniczni (obszary technologiczne)
- `principles/` – creedy (fundamentalne zasady)
- `base_rules/` – szczegółowe standardy pracy (testing, code quality, documentation, Django)

## Jak wybierać agentów, gdy nie są wskazani

1. **Zidentyfikuj charakter zadania** (np. UX, UI, architektura, API, dane, QA, performance).
2. **Dobierz role** z katalogu `roles`, które odpowiadają perspektywie zadania.
3. **Dobierz agentów technicznych** z `tech`, jeśli dotyczy konkretnej technologii.
4. **Dodaj 1–3 creedów** z `principles`, które najlepiej pilnują jakości decyzji w danym obszarze.
5. W PR dodaj notatkę, które agenty/creedy zostały użyte i dlaczego.

## Katalog agentów

### Roles (perspektywy decyzyjne)
- **Accessibility Oathkeeper** – dostępność i inkluzywność UI; używaj przy zmianach interfejsu i interakcji.
- **DevOps Gatekeeper** – stabilność dostarczenia, infra i operacji; używaj przy zmianach CI/CD, deployu, konfiguracji środowisk.
- **Performance Swiftblade** – wydajność, SLA i koszty zasobów; używaj gdy zmiana może wpływać na latency lub skalę.
- **Product Questmaster** – jasność wymagań i wartość produktowa; używaj przy doprecyzowaniu scope i acceptance criteria.
- **QA Witcher** – poprawność i testowalność; używaj przy planowaniu testów i weryfikacji zachowania.
- **Refactoring Purifier** – bezpieczeństwo refaktorów i dług techniczny; używaj przy porządkowaniu kodu i zmianach strukturalnych.
- **Security Paladin** – bezpieczeństwo, uprawnienia i ryzyka; używaj przy zmianach auth/authz, danych wrażliwych, integracjach.
- **Software Artificer** – projektowanie API na poziomie modułów i kodu; używaj przy projektowaniu struktur i kontraktów wewnętrznych.
- **System Worldshaper** – architektura systemu i granice modułów; używaj przy integracjach i decyzjach systemowych.
- **Technical Scribe** – dokumentacja i transfer wiedzy; używaj przy zmianach wymagających aktualizacji docs.
- **UI Enchanter** – spójność wizualna i warstwa UI; używaj przy zmianach wyglądu i komponentów.
- **UX Pathfinder** – logika interakcji i flow użytkownika; używaj przy projektowaniu doświadczenia i ścieżek.

### Tech (obszary technologiczne)
- **API Fixer** – stabilność i ewolucja kontraktów API; używaj przy zmianach endpointów i schematów.
- **Async Process Hacker** – joby i asynchroniczne workflowy; używaj przy kolejkach, retry, idempotencji.
- **CSS Neon Shaman** – spójność CSS i Bootstrap-first; używaj przy zmianach stylów.
- **Data Broker** – modele danych, migracje, spójność bazy; używaj przy zmianach schematu i danych.
- **Django Netrunner** – idiomatyczne użycie Django/DRF; używaj przy zmianach w warstwie Django.
- **Frontend Cybermonk** – logika frontendowa i stany UI; używaj przy interaktywnych elementach i JS.
- **Platform Ripper** – tooling i środowiska uruchomieniowe; używaj przy zmianach skryptów i konfiguracji dev/CI.
- **Python Samurai** – jakość kodu Python; używaj przy refaktorach i nowych modułach Python.
- **Telemetry Bounty Hunter** – obserwowalność i monitoring; używaj przy zmianach wymagających logów/metryk/alertów.

### Principles (creedy)
- **Creed of Simplicity** – minimalizm i brak overengineeringu; używaj przy ryzyku rozrostu scope.
- **Creed of Form** – forma = odpowiedzialność; używaj przy strukturze modułów/klas.
- **Creed of Boundaries** – granice i kontrakty; używaj przy integracjach i zależnościach.
- **Creed of Continuity** – spójność i ewolucja w czasie; używaj przy rozszerzaniu istniejących rozwiązań.
- **Creed of Clarity** – jednoznaczność i zrozumiałość; używaj przy wymaganiach i interfejsach.
- **Creed of Style** – czytelność i idiomatyczność; używaj przy jakości kodu i API.
- **Creed of Truth** – poprawność, deterministyczne zachowanie i jawne błędy.

## Podstawowe zasady pisania kodu

- **Czytelność ponad spryt** – kod ma być łatwy do zrozumienia i utrzymania.
- **Testy są obowiązkowe** – nowe zachowania muszą mieć testy.
- **Dokumentuj intencję** – docstringi i komentarze tylko tam, gdzie to naprawdę potrzebne.
- **Minimalny, spójny zakres** – nie dodawaj funkcji „na przyszłość”.
- **Spójne nazewnictwo i konwencje** – trzymaj się istniejących wzorców projektu.
- **Jawna obsługa błędów** – brak cichych wyjątków i „magii”.
- **Małe, bezpieczne kroki** – preferuj inkrementalne zmiany zamiast dużych przepisów.

## Podstawowe zasady pisania issue

Dobre issue powinno zawierać:
- **Cel i problem** – co ma zostać rozwiązane i dlaczego.
- **Zakres i poza zakresem** (non-goals).
- **Acceptance criteria** – testowalne, jednoznaczne.
- **Kontekst techniczny** – moduły, zależności, ograniczenia.
- **Ryzyka i kompromisy** – co może pójść źle.
- **Test plan** – jak sprawdzimy, że działa.
- **Wskazanie agenta/creedu** (jeśli ma być użyty) lub notatka, że agent ma dobrać sam.

---

## Weryfikacja końcowa (obowiązkowa)

Każda zmiana w repozytorium jest uznana za „done” dopiero po przejściu pełnej weryfikacji:
1) `pre-commit` (format/lint/konwencje)
2) `pytest` (testy)

### Procedura (pętla „do skutku”)

1. Uruchom `pre-commit` na całości zmian:
   - `pre-commit run --show-diff-on-failure --color=always --all-files`

2. Jeśli `pre-commit` nie przejdzie:
   - Przeanalizuj output (który hook, jakie pliki, jaki typ naruszenia).
   - Zastanów się, czy do kontekstu należy dołączyć dodatkowych agentów/creedy:
     - problemy z jakością Python / style / typowe błędy → **Python Samurai**, **Creed of Style**
     - problemy Django/DRF / konfiguracja / idiomy frameworka → **Django Netrunner**
     - problemy z architekturą granic / zależnościami → **System Worldshaper**, **Creed of Boundaries**
     - problemy refaktoryzacyjne / dług / rozjechane moduły → **Refactoring Purifier**, **Creed of Form**
     - problemy z testami / brak pokrycia / flaky tests → **QA Witcher**, **Creed of Truth**
     - problemy z toolingiem / CI / środowiskiem → **Platform Ripper**, **DevOps Gatekeeper**
   - Dołącz wybrane pliki agentów do kontekstu (zgodnie z zasadami systemu agentowego).
   - Popraw błędy w kodzie / konfiguracji.
   - Wróć do kroku 1.

3. Gdy `pre-commit` przejdzie, uruchom testy:
   - `docker compose -f docker-compose.local.yml run --rm django pytest`

4. Jeśli `pytest` nie przejdzie:
   - Przeanalizuj output (fail/traceback, błędne założenie testu vs bug w kodzie).
   - Dobierz agenta/creed do kontekstu na podstawie typu problemu np.:
     - logika testów / scenariusze / testowalność → **QA Witcher**
     - błąd domenowy / kontrakty / niejednoznaczne zachowanie → **Software Artificer**, **Creed of Truth**
     - błąd danych / migracji / integralności → **Data Broker**
     - błąd w API / schematach / zgodności kontraktu → **API Fixer**, **Creed of Boundaries**
     - błąd asynchroniczny / retry / idempotencja → **Async Process Hacker**
   - Dołącz wybrane pliki agentów do kontekstu.
   - Napraw kod i/lub testy (z zachowaniem intencji i zakresu).
   - Uruchom ponownie:
     - `pre-commit run --show-diff-on-failure --color=always --all-files  `
     - `docker compose -f docker-compose.local.yml run --rm django pytest`
   - Powtarzaj aż oba kroki przejdą.

### Definicja „zieloności”

Zmiana jest gotowa do PR / merge tylko jeśli:
- `pre-commit run --show-diff-on-failure --color=always --all-files` kończy się sukcesem,
- `docker compose -f docker-compose.local.yml run --rm django pytest` kończy się sukcesem,
- poprawki nie wprowadzają scope creep (zgodnie z Non-Goals),
- a dobór agentów został odnotowany (w PR lub notatce developerskiej).
