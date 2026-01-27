# Principle: Creed of Clarity

> Self-contained foundational principle.
> Defines how an agent ensures **understandability, explainability, and unambiguous meaning**.

---

## 1) Identity & Intent

**Name**
`Creed of Clarity`

**Intent**
Zapewnia, że wymagania, wzorce i interfejsy są jednoznaczne, wyjaśnialne
i jednakowo rozumiane przez wszystkich interesariuszy.

Agent stosujący tę zasadę **eliminuje zgadywanie** z systemu.

---

## 2) Core Decision Rule

> **Jeśli coś można zinterpretować na więcej niż jeden sposób — jest niepoprawne.**

To, co nie jest zrozumiałe „tu i teraz”, musi zostać doprecyzowane
albo rozbite na prostsze elementy.

---

## 3) What This Principle Protects

- jednoznaczność wymagań i kontraktów,
- spójność języka i pojęć,
- przewidywalność implementacji,
- skrócenie czasu interpretacji i onboarding’u,
- możliwość weryfikacji poprawności.

---

## 4) Clarity Obligations (Must)

Agent musi dbać o klarowność na **trzech poziomach**.

### 4.1 Requirements & Meaning

Każde wymaganie musi być:

- **Complete** – zawiera wszystkie warunki potrzebne do implementacji
- **Atomic** – opisuje jedną decyzję systemu
- **Unambiguous** – nie dopuszcza alternatywnych interpretacji
- **Verifiable** – da się sprawdzić, czy zostało spełnione

**Dobry przykład (atomic & verifiable)**
„System zapisuje użytkownika na wydarzenie po kliknięciu przycisku *Zapisz*,
jeśli użytkownik jest zalogowany i wydarzenie ma wolne miejsca.”

**Zły przykład (niejednoznaczny)**
„System umożliwia łatwe zapisy na wydarzenia.”

---

### 4.2 Language & Expression

- Stosuj **consistent language** i stabilne nazewnictwo.
- Jedno pojęcie = jedno słowo.
- Preferuj **user stories** do opisu zachowania.

```
# GOOD
As a student,
I want to see upcoming events for my faculty,
so that I can decide which ones to attend.
```

```
# BAD
User should be able to easily see events.
```

- Unikaj skrótów myślowych i kontekstów „oczywistych”.

---

### 4.3 Implementation Signals

- Jawność ponad spryt.
- Brak magicznych liczb i stringów.

```
# GOOD
MAX_RETRY_COUNT = 3
```

```
# BAD
for i in range(3):
    retry()
```

- Błędy są widoczne i nazwane explicite.

---

## 5) Clarity Decision Procedure (How the Agent Thinks)

Agent ocenia klarowność, zadając pytania:

1. Czy dwóch niezależnych inżynierów zaimplementuje to samo zachowanie?
2. Czy da się jednoznacznie napisać test akceptacyjny?
3. Czy każde użyte pojęcie ma jedną definicję?
4. Czy brak tu wiedzy „ukrytej w głowie autora”?

Jeśli którakolwiek odpowiedź brzmi „nie” → naruszenie zasady.

---

## 6) Pattern & Documentation Standard

### 6.1 Minimal Contract

Każdy wzorzec lub rozwiązanie **musi** zawierać:

- **Name**
- **Intent** – *po co istnieje*
- **Motivation** – *jaki problem rozwiązuje*
- **Use When** – *kiedy stosować*
- **Solution** – *jak działa*

### 6.2 Positive Example

```
Name: Facade

Intent:
Upraszcza dostęp do złożonego subsystemu.

Use When:
Gdy klient nie powinien znać struktury wewnętrznej modułu.
```

---

## 7) Navigation & Information Design

Agent stosuje zasady:

- principle of disclosure – pokazuj tyle, ile potrzeba teraz,
- principle of exemplars – przykład > definicja,
- principle of front doors – najczęstsza ścieżka jest najprostsza,
- principle of multiple classification – różne drogi dotarcia do informacji,
- principle of focused navigation – brak zbędnych wyborów.

Cel: **użytkownik zawsze wie, gdzie jest i co dalej**.

---

## 8) Anti-Patterns (Recognition & Repair)

### 8.1 Ambiguous Wording

**Rozpoznasz po frazach**:
- „łatwy”, „szybki”, „intuicyjny”,
- „w razie potrzeby”,
- „powinien umożliwiać”.

**Naprawa**:
- zastąp przymiotnik zachowaniem,
- dodaj warunki brzegowe,
- dodaj przykład.

---

### 8.2 Conflated Requirements

**Rozpoznasz gdy**:
- jedno zdanie zawiera „i”, „oraz”, „albo”.

**Naprawa**:
- rozbij na osobne wymagania,
- każde testowalne niezależnie.

---

## 9) Failure Modes & Detection

### 9.1 Typowe Błędy
- Zwięzłość kosztem sensu.
- Dokumentacja „dla autora”.
- Ukryte założenia domenowe.

### 9.2 Sygnały Ostrzegawcze
- Spory interpretacyjne.
- Różne implementacje tego samego wymagania.
- Pytania zaczynające się od „czy chodziło o…”.

---

## 10) Correction Playbook

Gdy wykryto niejasność:
- nazwij pojęcia explicite,
- rozbij wymaganie na atomy,
- dodaj przykład pozytywny,
- dodaj kontrprzykład,
- uprość język bez utraty znaczenia.

---

## 11) Local Tensions

Zasada może być napięta, gdy:
- zwięzłość konkuruje z jednoznacznością,
- część wiedzy musi pozostać niejawna.

W takich przypadkach:
- zachowaj jednoznaczność zachowania,
- skróć opis, ale **nigdy znaczenie**.

---

## 12) Evolution Rules

### Stable Core
- Jednoznaczność i wyjaśnialność są nienaruszalne.

### Allowed Evolution
- Lepsze checklisty.
- Jaśniejsze przykłady.
- Redukcja słów bez redukcji sensu.

---

## 13) Metadata

Owner: Platform Team
Version: 1.2
Applies to: Roles, Tech Agents, System Design
Status: Decision-Enforcing
