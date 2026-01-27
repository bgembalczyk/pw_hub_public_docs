# Principle: Creed of Simplicity

> Self-contained foundational principle.
> Defines how an agent protects the system from **unnecessary complexity and scope creep**.

---

## 1) Identity & Intent

**Name**
`Creed of Simplicity`

**Intent**
Chroni system przed rozrostem ponad realne potrzeby.
Wymusza wybór **najprostszego rozwiązania, które spełnia wymagania** — bez zapasu i bez finezji dla samej finezji.

Agent stosujący tę zasadę **aktywnie usuwa złożoność**.

---

## 2) Core Decision Rule

> **Jeśli rozwiązanie nie jest potrzebne teraz — nie powinno istnieć.**

Każdy element systemu musi mieć:
- jasno określoną wartość,
- realnego użytkownika,
- koszt mniejszy niż korzyść.

---

## 3) What This Principle Protects

- minimalny zakres funkcjonalny,
- niski koszt poznawczy (cognitive load),
- przewidywalność zachowania systemu,
- szybkie wdrażanie i modyfikacje,
- odporność na „przeprojektowanie”.

---

## 4) Simplicity Obligations (Must)

Agent musi egzekwować prostotę na **trzech poziomach**.

### 4.1 Scope & Features

- Zakres ograniczony do minimum potrzebnego do celu.
- Brak funkcji „na zapas” (**YAGNI**).

**YAGNI (You Aren’t Gonna Need It)**
Nie dodawaj funkcji/warstwy, dopóki nie istnieje potwierdzona potrzeba (realny przypadek użycia).

```
# GOOD: tylko to, co potrzebne teraz
def export_csv(rows): ...
```

```
# BAD: od razu „framework eksportów” bez wymagań
class ExportPipeline:
    def add_stage(self, ...): ...
```

- Każda funkcja ma określoną wagę i odbiorcę.

---

### 4.2 Structure & Abstractions

- Najpierw rozwiązanie proste, potem ewentualna abstrakcja.
- Jedna implementacja dla jednej istotnej funkcji.
- Mała liczba ścieżek decyzyjnych (**principle of choices**).

**Principle of choices**
Mniej opcji = mniej błędów i niższy koszt poznawczy.

```
# GOOD: jeden „domyślny” sposób działania
def send_notification(message): ...
```

```
# BAD: 10 trybów działania bez realnej potrzeby
def send_notification(message, mode="email", retries=3, fallback="sms", priority="normal", ...): ...
```

- Preferuj struktury płaskie nad zagnieżdżonymi.

---

### 4.3 Usage & Experience

- Prosta nawigacja i jasna ścieżka użycia.
- Odsłanianie informacji stopniowo (**principle of disclosure**).

**Principle of disclosure**
Pokazuj użytkownikowi minimum potrzebne do wykonania kroku, resztę dopiero, gdy jest potrzebna.

```
# GOOD: UI: najpierw podstawy, „zaawansowane” dopiero po kliknięciu
Settings: [Basic] [Advanced...]
```

```
# BAD: UI: wszystko naraz, użytkownik tonie w opcjach
Settings: 30 pól na jednym ekranie
```

- Minimalny wysiłek użytkownika, brak przeciążenia wizualnego (Deutsch limit).

**Deutsch limit (intuicja praktyczna)**
Użytkownik ma ograniczoną pojemność operacyjną – zbyt wiele elementów naraz obniża skuteczność.

---

## 5) Simplicity Decision Procedure (How the Agent Thinks)

Agent redukuje złożoność w tej kolejności:

1. **Usuń** (czy to w ogóle jest potrzebne teraz?)
2. **Ogranicz zakres** (czy da się zrobić mniejszą wersję?)
3. **Uprość przepływ** (czy da się zmniejszyć liczbę decyzji/gałęzi?)
4. **Skonsoliduj** (czy istnieje podobna rzecz już w systemie?)
5. **Dopiero wtedy abstrahuj** (czy istnieją realne warianty zachowania?)

Jeśli abstrakcja powstaje przed krokiem 5 → ryzyko overengineering.

---

## 6) Heuristics for Choosing Simpler Solutions

Agent zadaje te pytania przed akceptacją rozwiązania:

- Czy istnieje **prostsza wersja**, która spełnia wymagania?
- Czy złożoność wynika z problemu, czy z implementacji?
- Czy da się usunąć konfigurację zamiast ją dokumentować?
- Czy to rozwiązuje problem użytkownika, czy projektanta?
- Czy to można łatwo wytłumaczyć w kilku zdaniach?

> Jeśli implementacja jest trudna do wyjaśnienia — to zły znak.

---

## 7) Allowed Tools (When They Reduce Complexity)

Stosuj tylko, gdy **realnie upraszczają**:

- Lazy initialization (gdy koszt jest wysoki),
- Externalize the stack (gdy upraszcza przepływ),
- User stories (dla redukcji nieistotnych detali),
- Service granularity dopasowaną do realnej wartości,
- Ograniczenie wyborów zamiast ich mnożenia.

**Lazy initialization — przykład**

```
# GOOD: kosztowne obliczenie dopiero gdy potrzebne
class Report:
    def __init__(self):
        self._summary = None

    def summary(self):
        if self._summary is None:
            self._summary = compute_summary()
        return self._summary
```

```
# BAD: wszystko liczone zawsze, nawet gdy niepotrzebne
class Report:
    def __init__(self):
        self._summary = compute_summary()
```

---

## 8) Prohibitions (Must-Not)

Agent nie może:
- dodawać warstw, konfiguracji lub opcji bez mierzalnej korzyści,
- optymalizować przed potwierdzeniem problemu (**premature optimization**),
- budować własnych rozwiązań dla istniejących standardów,
- utrzymywać „kotwic” systemowych (**boat anchor**),
- mylić prostoty z pośpiechem lub bylejakością.

**Premature optimization — przykład**

```
# BAD: optymalizacja zanim wiadomo, że to bottleneck
def parse(data):
    # mikro-optymalizacje kosztem czytelności
    ...
```

```
# GOOD: najpierw czytelnie + pomiar, potem ewentualna optymalizacja
def parse(data):
    ...
# profile first
```

---

## 9) Anti-Patterns — Recognition & Repair

### 9.1 Speculative Abstraction
**Rozpoznasz gdy**:
- istnieje interfejs/warstwa bez realnych alternatyw,
- argumentem jest „na przyszłość”.

**Naprawa**:
- usuń abstrakcję,
- zostaw prostą implementację,
- dodaj punkt rozszerzenia dopiero, gdy pojawi się drugi wariant.

---

### 9.2 Configuration Explosion
**Rozpoznasz gdy**:
- nowe funkcje dodają parametry zamiast zachowań,
- dokumentacja rośnie szybciej niż kod.

**Naprawa**:
- ustal domyślne zachowanie,
- usuń opcje bez realnych użytkowników,
- zamień parametry na jeden „mode” o jasnej semantyce (jeśli konieczne).

---

### 9.3 Reinventing the Square Wheel
**Rozpoznasz gdy**:
- implementujesz to, co istnieje jako standard/biblioteka,
- argument brzmi „bo tak”.

**Naprawa**:
- użyj standardu,
- owiń adapterem tylko gdy musisz.

---

## 10) Failure Modes & Detection

### 10.1 Typowe Patologie
- Accidental complexity.
- Yo-yo problem (ciągłe skakanie po warstwach).
- Nadmiar opcji i konfiguracji.
- Reinventing the square wheel.

### 10.2 Sygnały Ostrzegawcze
- Wzrost liczby abstrakcji bez nowych wymagań.
- Rozwiązania wymagające długiego wprowadzenia.
- System trudniejszy w użyciu niż problem, który rozwiązuje.

---

## 11) Correction Playbook

Gdy prostota została naruszona:
- usuń zbędne elementy,
- cofaj się do minimalnej wersji działającej,
- połącz lub wytnij abstrakcje,
- zredukuj konfigurację,
- wymuś uzasadnienie każdej dodatkowej decyzji.

---

## 12) Local Tensions

Zasada może być napięta, gdy:
- prostota koliduje z krytyczną wydajnością,
- przyszła zmienność jest realna, ale niepewna,
- wymagania niefunkcjonalne wymuszają koszt (security/reliability/compliance).

W takich przypadkach:
- wybierz prostotę teraz,
- dokumentuj świadome odstępstwo,
- projektuj ścieżkę rozbudowy, nie rozbudowę.

---

## 13) Evolution Rules

### Stable Core
- Minimalna złożoność ma zawsze priorytet.

### Allowed Evolution
- Doprecyzowanie kryteriów „mierzalnej korzyści”.
- Usuwanie elementów wraz z dojrzewaniem systemu.
- Zastępowanie konfiguracji domyślnym zachowaniem.

---

## 14) Metadata

Owner: Platform Team
Version: 1.2
Applies to: Roles, Tech Agents, System Design
Status: Decision-Enforcing
