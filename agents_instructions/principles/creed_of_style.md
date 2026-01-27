# Principle: Creed of Style

> Self-contained foundational principle.
> Defines how an agent evaluates and enforces **readability, explicitness, and idiomatic expression** in code and APIs.

---

## 1) Identity & Intent

**Name**
`Creed of Style`

**Intent**
Zapewnia, że kod i interfejsy są **czytelne, przewidywalne i zrozumiałe dla człowieka**,
a nie tylko poprawne technicznie.

Chroni system przed „sprytnym kodem”, który wygląda krótko,
ale kosztuje czas, błędy i frustrację.

---

## 2) Core Decision Rule

> **Jeśli kod trzeba tłumaczyć — styl zawiódł.**

Dobry styl pozwala czytelnikowi:
- zrozumieć intencję bez komentarzy,
- przewidzieć skutki bez uruchamiania kodu,
- domyślić się poprawnego użycia API.

---

## 3) What This Principle Protects

- niski koszt czytania i utrzymania kodu,
- jawny przepływ sterowania i błędów,
- spójny „język” projektu,
- idiomatyczne użycie narzędzi i języka,
- estetyczną, oszczędną formę zamiast gęstości.

---

## 4) Style Obligations (Must)

Agent egzekwuje styl na **trzech poziomach**.

### 4.1 Readability First
- Czytelność ponad skrótowość.
- Kod czyta się częściej niż pisze.
- Lepiej dłużej, jeśli jaśniej.

**Przykład: rozbijanie gęstego kodu**

```
# BAD: gęste, trudne do debugowania
result = [x for x in items if f(x) and (g(x) or h(x)) and x.status in allowed]
```

```
# GOOD: jawne kroki i nazwy intencji
allowed_status = x.status in allowed
passes_rules = f(x) and (g(x) or h(x))

result = [x for x in items if passes_rules and allowed_status]
```

---

### 4.2 Explicit Control Flow
- Jawne warunki, jawne ścieżki, jawna obsługa błędów.
- Brak „magii” w przepływie wykonania.
- Efekty uboczne są widoczne w strukturze kodu.

**Przykład: guard clauses vs zagnieżdżenia**

```
# BAD: zagnieżdżenia ukrywają główną ścieżkę
def create_user(data):
    if data is not None:
        if "email" in data:
            if is_valid(data["email"]):
                return save(data)
    raise ValueError("Invalid input")
```

```
# GOOD: jawne warunki i wczesne wyjścia
def create_user(data):
    if data is None:
        raise ValueError("Missing data")
    if "email" not in data:
        raise ValueError("Missing email")
    if not is_valid(data["email"]):
        raise ValueError("Invalid email")

    return save(data)
```

**Przykład: błędy nie mogą ginąć**

```
# BAD: błąd „znika”
try:
    do_the_thing()
except Exception:
    pass
```

```
# GOOD: albo obsłuż jawnie, albo propaguj
try:
    do_the_thing()
except KnownError as e:
    logger.warning("Cannot do the thing: %s", e)
    return fallback()
```

---

### 4.3 Idiomatic & Consistent Expression
- Używaj idiomów języka, gdy **zwiększają czytelność**.
- Jeden styl w jednej warstwie.
- Spójne formatowanie, nazewnictwo i konwencje.

**Idiom ≠ popis**

```
# BAD: „spryt” dla sprytu
value = next(filter(lambda x: x.id == target, items), None)
```

```
# GOOD: prosty idiom, czytelny warunek
value = None
for item in items:
    if item.id == target:
        value = item
        break
```

---

## 5) Style Decision Procedure (How the Agent Thinks)

Agent ocenia styl w tej kolejności:

1. **Intencja**: czy z samej struktury widać „po co to jest”?
2. **Przepływ**: czy główna ścieżka jest najłatwiejsza do prześledzenia?
3. **Błędy**: czy obsługa błędów jest jawna i spójna?
4. **Nazwy**: czy nazwy mówią „co”, a nie „jak”?
5. **Idiom**: czy idiom zwiększa czytelność, czy ją obniża?
6. **Spójność**: czy to pasuje do stylu tej warstwy/projektu?

---

## 6) API & Interface Style

Styl dotyczy również **punktów styku**.

- API powinno sugerować poprawne użycie (ergonomics).
- Metody i argumenty mówią **co się stanie**, nie „jak”.
- API nie może mieć ukrytych skutków ubocznych bez sygnału.

**API, które prowadzi do dobrego użycia**

```
# GOOD: jawna intencja i wynik
result = payments.charge(card_id=..., amount=...)
if result.is_success:
    ...
else:
    ...
```

```
# BAD: niejasne skutki (czy to zapis? czy wysyłka? czy walidacja?)
payments.process(data)
```

### Fluent / chained APIs
Dozwolone, gdy:
- tworzą naturalny DSL,
- komunikują kolejność kroków,
- nie ukrywają błędów ani stanu.

```
# GOOD: DSL z czytelną kolejnością
query.filter(active=True).order_by("created_at").limit(10)
```

```
# BAD: chain z efektami ubocznymi i ukrytym stanem
builder.add(x).save().notify().commit()
```

### Null Object (when it improves reading)
Preferuj, gdy rozpraszasz obsługę `None`.

**Null Object — przykład**

```
# GOOD: klient nie musi robić if None
class NullLogger:
    def info(self, *args, **kwargs): ...
    def warning(self, *args, **kwargs): ...

logger = logger or NullLogger()
logger.info("Hello")
```

```
# BAD: None-checki wszędzie
if logger is not None:
    logger.info("Hello")
```

---

## 7) Naming & Documentation Style

### Naming
- Nazwy opisują intencję: `calculate_total()` zamiast `do_calc()`.
- Bool’e i predykaty brzmią jak pytania: `is_valid`, `has_access`.
- Unikaj skrótów, chyba że są domenowe i powszechne.

### Docstrings
- Wymagane, gdy funkcja:
  - ma nieoczywiste warunki brzegowe,
  - ma efekty uboczne,
  - jest częścią publicznego API.

---

## 8) Prohibitions (Must-Not)

Agent nie może:
- pisać „sprytnego” kodu kosztem zrozumiałości,
- ukrywać zachowania bez wyraźnego sygnału,
- mieszać stylów i konwencji w jednej warstwie,
- używać nieczytelnych nazw i skrótów myślowych,
- tworzyć interfejsów o niejasnych granicach i skutkach.

---

## 9) Anti-Patterns — Recognition & Repair

### 9.1 Clever One-Liners
**Rozpoznasz gdy**:
- jedna linia robi 3–5 rzeczy naraz,
- trudno ustawić breakpoint lub dodać log.

**Naprawa**:
- rozbij na kroki,
- nazwij wartości pośrednie.

---

### 9.2 Hidden Side Effects
**Rozpoznasz gdy**:
- getter zapisuje do DB,
- metoda o nazwie „compute” robi IO.

**Naprawa**:
- rename na intencyjne (`save_`, `fetch_`),
- rozdziel funkcję czystą od IO.

---

### 9.3 Swallowed Errors
**Rozpoznasz gdy**:
- `except: pass`,
- log bez kontekstu,
- brak re-raise.

**Naprawa**:
- zawęź wyjątek,
- dodaj kontekst,
- albo propaguj.

---

## 10) Review Heuristics

Podczas review agent zadaje pytania:

- Czy nowa osoba zrozumie ten kod bez kontekstu?
- Czy intencja wynika ze struktury, a nie z komentarzy?
- Czy przepływ sterowania jest oczywisty?
- Czy idiom został użyty dla czytelności, czy dla popisu?
- Czy API „prowadzi za rękę” do poprawnego użycia?

---

## 11) Failure Modes & Detection

### 11.1 Typowe Błędy
- Styl sprowadzony do formatowania.
- Nadmierna kondensacja logiki.
- „Jednolinijkowe arcydzieła”.

### 11.2 Sygnały Ostrzegawcze
- Kod wymaga komentarzy, by zrozumieć co robi.
- Krótki fragment ma nieoczywiste skutki uboczne.
- Czytelnik musi symulować wykonanie w głowie.

---

## 12) Correction Playbook

Gdy styl zawodzi:
- rozbij złożone wyrażenia na jawne kroki,
- nazwij pośrednie wartości,
- uprość przepływ sterowania,
- usuń „sprytne” konstrukcje,
- dostosuj do idiomu języka i stylu projektu.

---

## 13) Local Tensions

Styl może być napięty, gdy:
- idiomatyczna forma koliduje z wydajnością,
- skrót (np. comprehension) jest czytelniejszy niż wersja rozwlekła.

Zasada:
- **czytelność > skrót**,
- **jawność > spryt**,
- wyjątki są lokalne i świadome.

---

## 14) Evolution Rules

### Stable Core
- Czytelność i jawność mają zawsze priorytet.

### Allowed Evolution
- Doprecyzowanie idiomów.
- Dodawanie przykładów dobrych praktyk.
- Ujednolicanie stylu wraz z dojrzewaniem projektu.

---

## 15) Metadata

Owner: Platform Team
Version: 1.2
Applies to: Roles, Tech Agents, System Design
Status: Decision-Enforcing
