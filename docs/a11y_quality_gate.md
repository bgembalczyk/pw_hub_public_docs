# A11y Quality Gate — Focus, Contrast, Reduced Motion

## Cel i zakres
Ten dokument definiuje **obowiązkowy quality gate dostępności (a11y)** dla zmian w stylach i komponentach UI w panelach webowych (Bootstrap + custom overrides, DTL). Gate ma zapobiegać regresjom dostępności i wprowadza **jednolite, normatywne wymagania** dla:

- **widocznych i spójnych stanów focus**,
- **kontrastu kolorów** dla tekstu i elementów interaktywnych,
- **respektowania `prefers-reduced-motion`**.

**Zakres obowiązywania:**
- dotyczy **wszystkich zmian stylów, layoutu i komponentów UI**,
- obejmuje **wszystkie elementy interaktywne** (m.in. przyciski, linki, pola formularzy, przełączniki, checkboxy, radio, selecty, menu, zakładki, elementy z `role="button"`, niestandardowe komponenty JS/CSS),
- obowiązuje w panelach webowych (Django DTL) oraz wszędzie, gdzie UI jest renderowane w przeglądarce.

**Zasada nadrzędna:** dostępność nie jest opcjonalna. Każda zmiana UI **MUST** przejść gate i **MUST NOT** pogorszyć dostępności.

---

## 1) Focus visibility (MUST / SHOULD / MUST NOT)

### Wymagania MUST
- **Każdy element interaktywny MUST mieć widoczny fokus** w stanie `:focus-visible` (klawiatura) oraz **spójny** fokus między komponentami.
- **Fokus MUST być widoczny niezależnie od tła** i nie może opierać się wyłącznie na zmianie koloru tła/tekstu.
- **Nie wolno usuwać outline bez zastąpienia** równoważnym, czytelnym ringiem fokusowym.
- **Fokus MUST być widoczny na wszystkich stanach**: default, hover, active, error, disabled (jeśli fokus możliwy), loading.
- **Kolejność focusu MUST odpowiadać kolejności logicznej** w UI (tab order nie może „skakać”).

### Wymagania SHOULD
- Stosuj `:focus-visible` jako preferowany mechanizm, z fallbackiem do `:focus` tam, gdzie wsparcie przeglądarek jest niepewne.
- Ring focusu powinien mieć **min. 2px grubości** i **wyraźny kontrast** względem tła.
- Dla niestandardowych komponentów (np. custom select) fokus powinien obejmować **cały obszar interaktywny**, a nie tylko wewnętrzny element.

### Zakazy MUST NOT
- **MUST NOT** polegać wyłącznie na `box-shadow` o niskim kontraście lub tylko na zmianie koloru tekstu.
- **MUST NOT** ukrywać fokus przez `outline: none` bez równoważnej alternatywy.
- **MUST NOT** wymagać użycia myszy dla podstawowych akcji.

---

## 2) Color contrast (MUST / SHOULD / MUST NOT)

### Wymagania MUST
- **Tekst zwykły MUST spełniać kontrast min. 4.5:1** względem tła.
- **Tekst duży (≥ 18pt lub ≥ 14pt bold) MUST spełniać min. 3:1**.
- **Elementy interaktywne (ikony, obramowania, ring focusu, kontrolki)** MUST mieć **min. 3:1** względem tła.
- **Stany błędu i focusu MUST być czytelne** (kontrast nie może spadać poniżej minimalnych progów).
- **Disabled MUST pozostać czytelny** – obniżenie kontrastu jest dopuszczalne tylko, jeśli **czytelność pozostaje** (min. 3:1 dla tekstu i ikon).

### Wymagania SHOULD
- Unikaj przekazywania informacji **wyłącznie kolorem** (dodaj ikonę/etykietę/tekst).
- Dla tła o zmiennej kolorystyce (gradienty, obrazy) stosuj dodatkowe tła lub obramowania, aby utrzymać kontrast.

### Zakazy MUST NOT
- **MUST NOT** używać kombinacji kolorów o kontraście poniżej minimum w stanach hover/focus/active.
- **MUST NOT** obniżać kontrastu w trybach „secondary/ghost” poniżej wymagań.

---

## 3) Reduced motion (MUST / SHOULD / MUST NOT)

### Wymagania MUST
- **UI MUST respektować `prefers-reduced-motion: reduce`** i redukować animacje/transition do minimum.
- **Przy `reduce` wszelkie animacje niekrytyczne MUST zostać wyłączone** lub skrócone do wartości niemal natychmiastowych (np. `duration: 1ms`).
- **Informacja nie może być przekazywana wyłącznie ruchem**; musi istnieć równoważna, statyczna forma.

### Wymagania SHOULD
- Stosuj media query:
  - `@media (prefers-reduced-motion: reduce)`
  - wyłącz `scroll-behavior: smooth`, parallax i animacje dekoracyjne.
- Zachowuj spójne zachowanie komponentów: jeśli jeden komponent redukuje motion, analogiczne komponenty też powinny.

### Zakazy MUST NOT
- **MUST NOT** wymuszać animacji, które utrudniają zrozumienie treści w trybie reduce.
- **MUST NOT** ukrywać treści poprzez animacje, jeśli nie ma natychmiastowej alternatywy.

---

## 4) Quality Gate — kiedy i kto

### Kiedy sprawdzamy
- **Każda zmiana stylów lub komponentów UI MUST przejść gate**.
- Gate obowiązuje **przed merge** (PR review) oraz **przed wydaniem**.

### Kto odpowiada
- **Autor zmian**: przygotowuje self-checklistę i dowody (np. zrzuty, opis).
- **Reviewer (frontend/UX)**: weryfikuje zgodność z wymaganiami.
- **QA**: wykonuje checklisty i test plan manualny (co najmniej happy-path).

---

## 5) Checklisty weryfikacyjne

### Focus
- [ ] Każdy element interaktywny ma **widoczny fokus**.
- [ ] Fokus **nie opiera się wyłącznie na kolorze** (jest ring/obramowanie).
- [ ] `:focus-visible` działa z klawiaturą (Tab / Shift+Tab).
- [ ] Tab order jest logiczny, bez „skoków”.
- [ ] Fokus widoczny w stanach hover/active/error.

### Kontrast
- [ ] Tekst i ikony spełniają minimalny kontrast (4.5:1 lub 3:1 dla dużego tekstu).
- [ ] Fokus ring i error states są czytelne na każdym tle.
- [ ] Disabled nie traci czytelności poniżej minimum.
- [ ] Informacja nie jest przekazywana wyłącznie kolorem.

### Reduced motion
- [ ] UI respektuje `prefers-reduced-motion: reduce`.
- [ ] Animacje są wyłączone lub skrócone do minimum.
- [ ] Brak kluczowych informacji przekazywanych wyłącznie ruchem.
- [ ] Alternatywa statyczna jest czytelna.

---

## 6) Acceptance Criteria (AC)
- [ ] Każdy komponent interaktywny ma widoczny fokus.
- [ ] Kontrast jest wystarczający we wszystkich stanach.
- [ ] UI działa poprawnie przy `prefers-reduced-motion: reduce`.
- [ ] Gate jest stosowany przy każdej zmianie stylów/komponentów UI.
- [ ] Wszelkie wyjątki są jawnie udokumentowane.

---

## 7) Manual Test Plan (Happy + Edge)

1. **Nawigacja klawiaturą:** użyj Tab / Shift+Tab na wszystkich ekranach objętych zmianą.
2. **Focus:** sprawdź widoczność focusu na każdym elemencie interaktywnym.
3. **Kontrast:** zweryfikuj kontrast tekstu i kontrolki w stanach default/hover/active/error/disabled.
4. **Reduced motion:** włącz ustawienie systemowe `prefers-reduced-motion: reduce`, odśwież UI i sprawdź brak/skrót animacji.
5. **Edge:** sprawdź elementy niestandardowe (np. custom select, menu, modale) i ich fokus.

---

## 8) Wyjątki i eskalacja

Wyjątki są **dopuszczalne tylko w wyjątkowych sytuacjach** i **MUST być jawnie udokumentowane**:

- opis problemu i uzasadnienie,
- wpływ na użytkowników,
- plan i termin usunięcia wyjątku,
- owner odpowiedzialny za domknięcie.

**Miejsce dokumentacji:** opis w PR + wpis w sekcji „Rejestr wyjątków” w tym dokumencie.

### Rejestr wyjątków (aktualnie brak)
- Brak aktywnych wyjątków.

---

## 9) Integracja z procesem (Gate)

- **PR review:** gate jest obowiązkowym punktem akceptacji zmian UI.
- **QA manual:** checklisty i test plan są wymagane dla zmian styli/komponentów.
- **CI / pre-commit (opcjonalnie):** jeśli pojawią się narzędzia automatyczne, muszą potwierdzać zgodność z tym dokumentem, ale **nie zastępują** manualnej weryfikacji.

---

## 10) Źródła i odpowiedzialności

- Ten dokument jest **Source of Truth** dla a11y gate.
- Każdy komponent UI podlega tym samym zasadom (Creed of Consistency).
- Wątpliwości eskalujemy do: **Accessibility Oathkeeper + QA Witcher + UX Pathfinder**.

