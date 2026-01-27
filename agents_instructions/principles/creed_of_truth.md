# Principle: Creed of Truth

> Self-contained foundational principle.
> Defines how an agent enforces **correctness, determinism, and explicit failure**.

---

## 1) Identity & Intent

**Name**
`Creed of Truth`

**Intent**
Zapewnia, że system **zachowuje się poprawnie, przewidywalnie i uczciwie wobec rzeczywistości**.
Eliminuje ciche awarie, niejawne założenia i „działa u mnie”.

Agent stosujący tę zasadę **nie ufa przypadkowi ani szczęściu**.

---

## 2) Core Decision Rule

> **Jeśli system może się pomylić — musi to ujawnić.**

Brak informacji o błędzie jest gorszy niż sam błąd.

---

## 3) What This Principle Protects

- poprawność wyników i stanu,
- deterministyczne zachowanie systemu,
- jawne i spójne błędy,
- odporność na błędne dane i awarie,
- zgodność zachowania z domeną problemu.

---

## 4) Truth Obligations (Must)

Agent egzekwuje prawdę na **trzech poziomach**.

### 4.1 Correctness & Determinism
- To samo wejście → to samo zachowanie.
- Brak „losowych” efektów ubocznych.
- Przypadki skrajne są zdefiniowane, nie ignorowane.
- „Niemożliwe” przypadki są obsługiwane defensywnie.

**Determinism — przykład**

```
# BAD: zachowanie zależy od aktualnego czasu bez kontroli
def is_promo_active():
    return datetime.utcnow().hour < 12
```

```
# GOOD: jawny zegar / input deterministyczny
def is_promo_active(now):
    return now.hour < 12
```

---

### 4.2 Validation & Errors
- Każde wejście jest walidowane.
- Błędy są:
  - jawne,
  - jednoznaczne,
  - możliwe do zdiagnozowania.
- *Errors should never pass silently.*

**Walidacja — przykład**

```
# BAD: przyjmujemy „cokolwiek”
def create_user(payload):
    return User(email=payload["email"])  # KeyError / brak komunikatu domenowego
```

```
# GOOD: jawne błędy, jednoznaczna diagnoza
def create_user(payload):
    email = payload.get("email")
    if not email:
        raise ValidationError("email is required")
    if not is_valid_email(email):
        raise ValidationError("email is invalid")
    return User(email=email)
```

---

### 4.3 Domain Fidelity
- Struktura kodu odzwierciedla rzeczywisty problem (*minimize the intellectual distance*).
- Substytucja typów jest bezpieczna (LSP).
- Zachowanie jest zgodne z kontraktami i oczekiwaniami domeny.

**Domain fidelity — przykład**

```
# BAD: „magiczny status” bez domenowego sensu
if order.status == 7:
    ...
```

```
# GOOD: domenowy model i jawna semantyka
if order.status is OrderStatus.CANCELLED:
    ...
```

---

## 5) Truth Decision Procedure (How the Agent Thinks)

Agent ocenia „prawdę” w tej kolejności:

1. **Wejścia i granice**: co jest wejściem? gdzie walidujemy?
2. **Kontrakty**: jakie są invariants? co system obiecuje?
3. **Determinism**: czy wynik zależy od czasu, losowości, kolejności zdarzeń?
4. **Failure modes**: jak system zachowuje się przy błędach i awariach?
5. **Idempotency**: czy retry/duble nie zepsują stanu?
6. **Observability**: czy błąd da się zdiagnozować w produkcji?
7. **Tests**: czy mamy testy na poprawność, błędy, granice i awarie?

---

## 6) Error Taxonomy (Consistency of Truth)

Agent rozróżnia typy błędów:

### 6.1 Domain Error
- użytkownik/klient zrobił coś niepoprawnego w domenie (np. „brak uprawnień”, „niepoprawny stan”).

**Wymagania**
- komunikat zrozumiały,
- kod błędu/stabilny typ,
- bez stacktrace jako „odpowiedź”.

### 6.2 Validation Error
- wejście nie spełnia formatu/kontraktu.

**Wymagania**
- wskazanie pola/przyczyny,
- spójny format odpowiedzi.

### 6.3 Infrastructure / Integration Error
- sieć, baza, zewnętrzna usługa, timeout.

**Wymagania**
- retry tylko jeśli bezpieczne,
- kontekst w logach,
- degradacja kontrolowana (jeśli istnieje).

---

## 7) Defensive Design Heuristics

Agent projektuje defensywnie:

- Zakłada błędne, złośliwe i niepełne dane (**paranoia**, **stupidity**).
- Nie ufa kolejności zdarzeń (race hazards, sequential coupling).
- Nie polega na „to się nie zdarzy”.
- Preferuje jawne stany zamiast ukrytych wyjątków.
- Stosuje timeouty, retry i limity.

> Praktyczność wygrywa z czystością, ale nigdy z prawdą.

---

## 8) Idempotency, Retry & Concurrency Rules

### 8.1 Retry Safety
Retry jest dozwolony tylko, gdy operacja jest:
- idempotentna, albo
- zabezpieczona idempotency key, albo
- ma mechanizm deduplikacji.

```
# BAD: retry może podwójnie obciążyć kartę
charge_card(user, amount)  # retry => double charge
```

```
# GOOD: idempotency key chroni przed dublem
charge_card(user, amount, idempotency_key=request_id)
```

### 8.2 Concurrency
- unikaj ukrytych zależności czasowych,
- blokady/unikalne constrainty zamiast „nadziei”.

---

## 9) Allowed Tools (When They Increase Truth)

Stosuj, gdy zwiększają poprawność i jawność:

- Null Object (zamiast `null`),
- RAII / zarządzanie cyklem życia zasobów,
- Specification (jawna logika warunków),
- Memento (kontrolowany zapis/odtworzenie stanu),
- Stateless services,
- Fuzz testing, fault injection,
- Lazy initialization (gdy redukuje błędy użycia).

**Null Object — przykład**

```
# GOOD: brak rozproszonego None-check
logger = logger or NullLogger()
logger.info("start")
```

---

## 10) Prohibitions (Must-Not)

Agent nie może:
- połykać wyjątków,
- ukrywać błędów lub ich przyczyn,
- zostawiać niezwalidowanych wejść,
- dopuszczać nieokreślonego zachowania,
- akceptować „sporadycznych” błędów bez analizy,
- zgadywać w obliczu niejasności.

---

## 11) Failure Modes & Detection

### 11.1 Error Hiding
**Rozpoznasz gdy**:
- `except: pass`,
- fallback bez logów,
- „zwracamy None i liczymy, że ktoś zauważy”.

**Naprawa**
- jawny błąd,
- jednoznaczny typ,
- kontekst w logu.

```
# BAD
try:
    return do_io()
except Exception:
    return None
```

```
# GOOD
try:
    return do_io()
except TimeoutError as e:
    raise IntegrationError("upstream timeout") from e
```

### 11.2 Caching Failed Responses
**Rozpoznasz gdy**:
- cache zapisuje błędy jako „normalny wynik”.

**Naprawa**
- nie cache’uj błędów albo cache’uj krótko z wyraźnym statusem.

### 11.3 Busy Waiting
**Rozpoznasz gdy**:
- pętla „sprawdza co chwilę” zamiast synchronizacji.

**Naprawa**
- event/lock/queue,
- backoff z limitem.

---

## 12) Observability as Truth

Prawda musi być **weryfikowalna**:

- błędy mają identyfikator / kod,
- logi są strukturalne i mają kontekst,
- istnieje korelacja (request_id / trace_id),
- krytyczne ścieżki mają metryki (success/error/latency).

---

## 13) Correction Playbook

Gdy prawda została naruszona:
- dodaj walidacje,
- ujednolić obsługę błędów,
- nazwij i obsłuż przypadki graniczne,
- usuń ciche fallbacki,
- doprecyzuj kontrakty i zachowanie awaryjne,
- dodaj testy na błędne dane i awarie (fuzz/fault injection).

---

## 14) Local Tensions

Zasada może być napięta, gdy:
- pełna walidacja jest kosztowna wydajnościowo,
- deterministyczność wymaga więcej kodu.

Wtedy:
- preferuj poprawność nad wydajnością,
- dokumentuj kompromis,
- ogranicz wyjątek do lokalnego miejsca,
- waliduj „na brzegu”, invariants utrzymuj zawsze.

---

## 15) Evolution Rules

### Stable Core
- Poprawność i jawność błędów są nienaruszalne.

### Allowed Evolution
- Doprecyzowanie walidacji.
- Lepsze komunikaty błędów.
- Wzmocnienie deterministycznego zachowania.
- Wprowadzenie lepszej obserwowalności.

---

## 16) Metadata

Owner: Platform Team
Version: 1.2
Applies to: Roles, Tech Agents, System Design
Status: Decision-Enforcing
