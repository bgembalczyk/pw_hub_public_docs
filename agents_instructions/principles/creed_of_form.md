# Principle: Creed of Form

> Self-contained foundational principle.
> Defines how an agent ensures that **structure mirrors responsibility** and communicates intent.

---

## 1) Identity & Intent

**Name**
`Creed of Form`

**Intent**
Forma kodu (klasy, funkcje, moduły, interfejsy) ma jasno odzwierciedlać **odpowiedzialności**.
Minimalizuje błędy wynikające z mylącej struktury, złej hierarchii i nieczytelnych abstrakcji.

---

## 2) Core Decision Rule

> **Jeśli nie da się w jednym zdaniu powiedzieć, „za co odpowiada ta jednostka”, to forma jest zła.**

Struktura powinna pozwalać czytelnikowi przewidzieć:
- gdzie należy coś dopisać,
- gdzie nie wolno,
- jakie są punkty rozszerzeń,
bez zgadywania i bez skakania po plikach.

---

## 3) What This Principle Protects

- spójne, jednoznaczne odpowiedzialności,
- wysoką kohezję i sensowną dekompozycję,
- enkapsulację i przewidywalne API,
- rozszerzalność bez łamania struktury,
- brak „zaskoczeń” w zachowaniu komponentów (POLA).

---

## 4) Design Rules of Form

### 4.1 Responsibility & Cohesion
- Jednostka ma **jedną rolę** i jedną oś zmiany.
- Trzymaj razem to, co zmienia się razem (cohesion).
- Dekompozycja (divide-and-conquer) jest obowiązkiem, gdy rośnie złożoność.

**Cohesion — przykład**

```
# GOOD: rzeczy, które zmieniają się razem, są razem
class InvoicePricing:
    def net_amount(self, items): ...
    def vat_amount(self, items): ...
    def gross_amount(self, items): ...
```

```
# BAD: „zlepek” odpowiedzialności z różnych osi zmiany
class InvoiceStuff:
    def render_pdf(self): ...
    def calculate_vat(self): ...
    def send_email(self): ...
```

---

### 4.2 Encapsulation & Interfaces
- Stan + zachowanie są spakowane razem (encapsulation).
- API ukrywa detale i zmniejsza pole przypadkowych użyć.
- Interfejsy są **małe i celowane** (ISP); brak „interface bloat”.

**Encapsulation — przykład**

```
# GOOD: klient nie zna detali stanu
class Cart:
    def add_item(self, item_id, qty): ...
    def total(self): ...
```

```
# BAD: klient manipuluje wnętrzem
cart.items.append(...)
cart.discounts["BLACKFRIDAY"] = 0.2
```

**ISP — przykład**

```
# GOOD: małe role-interfaces
class CanRenderHTML: ...
class CanExportCSV: ...
```

```
# BAD: jeden interfejs „do wszystkiego”
class Report:
    def render_html(self): ...
    def export_csv(self): ...
    def send_email(self): ...
    def save_to_s3(self): ...
```

---

### 4.3 Composition over Inheritance
- Preferuj kompozycję i delegowanie nad dziedziczenie.
- Dziedziczenie tylko, gdy relacja **IS-A** jest prawdziwa i stabilna (LSP).
- Subklasa nie może łamać kontraktu superklasy (substitutability).

**Kompozycja vs dziedziczenie — przykład**

```
# GOOD: kompozycja
class AuthenticatedClient:
    def __init__(self, base_client, token_provider):
        self._base = base_client
        self._token_provider = token_provider

    def get(self, url):
        token = self._token_provider.get()
        return self._base.get(url, headers={"Authorization": f"Bearer {token}"})
```

```
# BAD: dziedziczenie tylko dla reuse
class AuthenticatedClient(HttpClient):
    def get(self, url):
        # override + super calls, kontrakt niejasny
        ...
```

**LSP — przykład**

```
# BAD: subklasa łamie kontrakt (np. rzuca wyjątek w miejscu gdzie baza nie rzuca)
class BaseCache:
    def get(self, key) -> str | None: ...

class ExplodingCache(BaseCache):
    def get(self, key) -> str | None:
        raise RuntimeError("offline")  # łamie oczekiwanie klienta
```

---

### 4.4 Predictability
- Forma ma nie zaskakiwać: **principle of least astonishment**.
- Nazwy, moduły i kierunek zależności mają mówić „jak to się używa”.

**POLA — przykład**

```
# GOOD: nazwa i miejsce sugerują użycie
# payments/service.py
class PaymentService:
    def charge(self, request): ...
```

```
# BAD: „zaskoczenie” — klasa o nazwie Repository robi requesty HTTP
class PaymentRepository:
    def charge_card(self):  # robi zewnętrzne IO
        ...
```

---

## 5) Form Decision Procedure (How the Agent Thinks)

Agent ocenia zmianę w tej kolejności:

1. **Nazwij odpowiedzialność jednym zdaniem**
   - jeśli nie możesz → rozbij lub zmień nazwę/kształt.

2. **Sprawdź oś zmiany**
   - jeśli w jednym miejscu mieszają się różne powody zmian → podziel.

3. **Sprawdź granice API**
   - czy użytkownik musi znać wnętrze?
   - jeśli tak → wzmocnij enkapsulację.

4. **Sprawdź warianty zachowania**
   - jeśli jest `if type == ...` / `match` po typach → Strategy/State.

5. **Sprawdź hierarchię**
   - jeśli dziedziczenie jest tylko dla reuse → kompozycja.

---

## 6) Allowed Patterns (Tools of Form)

Stosuj, gdy poprawiają dopasowanie formy do roli:

- **Strategy**: warianty algorytmu bez if-else typu.
- **State**: zmiana zachowania wraz ze stanem.
- **Composite / Aggregate**: struktury część–całość.
- **Decorator**: rozszerzanie bez subklasowania.
- **Template Method**: stały szkielet + zmienne kroki (ostrożnie).
- **Servant / Helper**: tylko dla funkcji naprawdę wspólnych (bez „śmietnika” statyków).

**Strategy — przykład**

```
# BAD: type-check / if-else
def price(order):
    if order.kind == "student":
        return base(order) * 0.8
    if order.kind == "vip":
        return base(order) * 0.7
    return base(order)
```

```
# GOOD: Strategy
class PricingStrategy:
    def price(self, order): ...

class StudentPricing(PricingStrategy): ...
class VipPricing(PricingStrategy): ...
class DefaultPricing(PricingStrategy): ...
```

> Wzorzec jest poprawny tylko, jeśli **zmniejsza złożoność mentalną** i wyjaśnia rolę.

---

## 7) Prohibitions (Must-Not)

Agent nie może:
- tworzyć „wszystkorobiących” obiektów (god objects),
- łączyć niepowiązanych obowiązków w jednej strukturze (multifaceted abstraction),
- używać dziedziczenia tylko do współdzielenia kodu,
- utrwalać hierarchii, gdzie IS-A jest nieprawdziwe (broken hierarchy),
- pisać logiki przez ręczne type-checki zamiast polimorfizmu (unexploited encapsulation),
- dopuszczać rozrostu interfejsów i UI bez intencji (interface bloat).

---

## 8) Anti-Patterns — Recognition & Repair

### 8.1 God Object
**Rozpoznasz gdy**:
- klasa ma „dziesiątki” metod z różnych tematów,
- importuje połowę systemu,
- jest używana „wszędzie”.

**Naprawa**:
- wydziel komponenty po osi zmiany,
- zostaw w tej klasie tylko orkiestrację.

---

### 8.2 Interface Bloat
**Rozpoznasz gdy**:
- interfejs wymusza metody, których część implementacji nie używa,
- rośnie lista metod „bo ktoś potrzebował”.

**Naprawa**:
- rozbij na role-interfaces (ISP),
- użyj adapterów dla kompatybilności.

---

### 8.3 Broken Hierarchy
**Rozpoznasz gdy**:
- subklasy override’ują połowę metod „na inaczej”,
- klient musi wiedzieć „jaką subklasę ma”.

**Naprawa**:
- kompozycja + delegowanie,
- Strategy/State zamiast dziedziczenia.

---

## 9) Review Checklist (Fast)

Podczas review agent odpowiada „tak/nie”:

- Czy da się opisać odpowiedzialność jednostki jednym zdaniem?
- Czy pola i metody należą do tej samej osi zmiany?
- Czy interfejs jest mały i celowany (ISP)?
- Czy kompozycja byłaby czytelniejsza niż dziedziczenie?
- Czy subtyp może bezpiecznie zastąpić supertyp (LSP)?
- Czy użytkownik API nie musi znać wnętrza (encapsulation)?
- Czy struktura prowadzi do przewidywalnego miejsca zmiany?

---

## 10) Failure Modes & Detection

### 10.1 Common Misinterpretations
- „Ładna architektura” = dużo warstw / dużo klas.
- „Reużywalność” jako cel sam w sobie, bez realnego użycia.

### 10.2 Detection Signals
- Trudność w opisaniu roli klasy/funkcji.
- Duże pliki, duże klasy, klasy „od wszystkiego”.
- Zbyt wiele zależności wychodzących lub zbyt szerokie API.
- Dziwne dziedziczenie i częste `super()` bez sensu domenowego.
- Pojawiające się „switch po typach” / if-else od wariantów.

---

## 11) Correction Playbook

Gdy forma nie pasuje do odpowiedzialności:
- rozbij jednostkę na mniejsze komponenty o jednej roli,
- zamień dziedziczenie na delegowanie/kompozycję,
- wytnij zbędne metody z interfejsu, twórz role-interfaces (ISP),
- przenieś warianty zachowania do Strategy/State zamiast type-checków,
- wzmocnij enkapsulację: publiczne API, prywatne detale,
- usuń „helper-śmietnik” i zastąp go sensownymi obiektami lub usługami.

---

## 12) Stop Rules (When NOT to Reshape Form)

Agent NIE powinien rozbijać/komplikować formy, jeśli:
- nie ma realnej osi zmiany (to jednorazowy, prosty przypadek),
- refaktor zwiększy liczbę bytów bez wzrostu czytelności,
- tworzyłby abstrakcję bez różnic zachowania (Simplicity/YAGNI).

Preferuj małe, lokalne poprawki formy zamiast „przebudowy świata”.

---

## 13) Local Tensions

Zasada może być napięta, gdy:
- rozdział odpowiedzialności zwiększa liczbę modułów,
- istnieją historyczne zależności utrudniające refaktor.

Wtedy:
- priorytetem jest **czytelny kierunek** zmian i stabilne API,
- refaktor wykonuj iteracyjnie, ale bez dokładania nowych wyjątków strukturalnych.

---

## 14) Evolution Rules

### Stable Core
- Forma zawsze odzwierciedla odpowiedzialność.
- Struktura ma komunikować intencję.

### Allowed Evolution
- Dalsza dekompozycja dla kohezji.
- Zmiana dziedziczenia na kompozycję.
- Podział interfejsów na mniejsze role.

---

## 15) Metadata

Owner: Platform Team
Version: 1.2
Applies to: Roles, Tech Agents, System Design
Status: Decision-Enforcing
