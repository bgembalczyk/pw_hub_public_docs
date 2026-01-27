# Creed of Boundaries — Extended Decision Contract

> Supplement to the core principle.
> Focused on **decision-making, recognition, and correction**.

---

## 1) Identity & Intent

**Name**
`Creed of Boundaries`

**Intent**
Chroni system przed ukrytym sprzężeniem.
Wymusza jawne granice, stabilne kontrakty i izolację odpowiedzialności.

Agent stosujący tę zasadę **myśli granicami**, a nie klasami czy funkcjami.

---

## 2) Core Decision Rule

> **Każda zależność musi mieć wyraźny powód, kierunek i kontrakt.**

Jeśli agent **nie potrafi nazwać granicy**, to znaczy, że ona nie istnieje — a system już przecieka.

---

## 3) What This Principle Protects

- izolację modułów i warstw,
- ukrycie informacji i detali implementacyjnych,
- stabilne, jawne interfejsy,
- możliwość lokalnej zmiany bez efektu domina,
- zrozumiały graf zależności (bez cykli).

---

## 4) Boundary Design Heuristics

Stosuj zasadę, gdy projektujesz lub oceniasz:

### 4.1 Modules & Layers
- Moduł grupuje **spójną odpowiedzialność**, nie przypadkowe klasy.
- Warstwy nie mogą być omijane „na skróty”.
- Granica = miejsce, gdzie **kończy się wiedza jednego komponentu**.

### 4.2 Information & Data Hiding
- Dostęp do wnętrza tylko przez **jawne API**.
- Brak dostępu do struktur danych „bo łatwiej”.
- Użytkownicy komponentu nie znają jego wnętrza.

### 4.3 Dependencies
- Preferuj **kierunkowe, acykliczne zależności** (ADP).
- Unikaj cykli, hierarchii cyklicznych i „action at a distance”.
- Nie używaj bazy danych jako IPC.

### 4.4 Contracts over Convenience
- Interfejs to **kontrakt**, nie techniczna abstrakcja.
- Stabilność kontraktu > wygoda implementacji.
- Dokumentuj zależności jawnie.

---

## 5) Boundary Types (Explicit Classification)

Agent musi najpierw rozpoznać **z jakim typem granicy ma do czynienia**:

### 5.1 Domain Boundary
Oddziela **pojęcia biznesowe i modele mentalne**.

**Dobry przykład**
Order nie zna PaymentDetails — komunikuje się przez intent (e.g. `request_payment()`).

**Zły przykład**
Order importuje klasy z `payments.models`.

---

### 5.2 Technical Boundary
Oddziela **framework, IO, infrastrukturę** od logiki.

**Dobry przykład**
Logika domenowa nie importuje Django ORM ani HTTP.

**Zły przykład**
Model domenowy woła `requests.post()`.

---

### 5.3 Organizational Boundary
Odzwierciedla **odpowiedzialność zespołów / ownership**.

**Dobry przykład**
API jest kontraktem, a nie współdzielonym modelem.

**Zły przykład**
Dwa zespoły edytują te same klasy „bo szybciej”.

---

### 5.4 Runtime Boundary
Oddziela **procesy, async, sieć, pamięć**.

**Dobry przykład**
Retry i timeout są częścią kontraktu.

**Zły przykład**
Zakładanie, że „to zawsze odpowie”.

---

## 6) Use of Abstractions (Critical Balance)

### 6.1 Allowed
- Dependency Inversion, gdy **istnieje realna zmienność**.
- Adapter, Facade, Mediator — gdy chronią granice.
- Strategy, Bridge — gdy oddzielają odpowiedzialności.

### 6.2 Forbidden Abuse
- DIP „wszędzie, bo testy”.
- Interfejsy istniejące tylko dla mocków.
- Abstrakcje bez alternatywnych implementacji.
- „Namespace dumping” bez semantycznej granicy.

> Abstrakcja bez napięcia zmiany jest tylko hałasem.

---

## 7) Boundary Decision Procedure (How the Agent Thinks)

Przy każdej nowej zależności agent przechodzi kroki:

1. **Czy potrafię nazwać granicę jednym zdaniem?**
   - jeśli nie → granica nie istnieje

2. **Czy znam kierunek zależności?**
   - jeśli dwukierunkowa → naruszenie

3. **Czy kontrakt jest stabilniejszy niż implementacja?**
   - jeśli nie → przeciek

4. **Czy zmiana po drugiej stronie mnie boli?**
   - jeśli tak → złamana izolacja

---

## 8) Positive Boundary Patterns (What “Good” Looks Like)

### 8.1 Facade Boundary
Chroni złożoność i zmienność.

```
# GOOD
class BillingFacade:
    def charge(self, order_id: OrderId) -> ChargeResult:
        ...
```

```
# BAD
from payments.stripe.internal import StripeSession
```

---

### 8.2 DTO as Contract (Not Model)
DTO ≠ domena.

```
# GOOD
PaymentRequest(amount, currency)
```

```
# BAD
serialize(DjangoModel)
```

---

## 9) Failure Modes & Detection

### 9.1 Typowe Patologie
- Object orgy / object cesspool.
- Broken modularization.
- Stovepipe systems.
- Hard-coded konfiguracja.
- Law of Demeter violations.

### 9.2 Sygnały Ostrzegawcze
- Zależności przechodzące przez wiele warstw.
- Publiczne DTO ujawniające model domeny.
- Zmiana w jednym module psuje wiele innych.
- Trudność w wyjaśnieniu „kto za co odpowiada”.

---

## 10) Anti-Patterns — Recognition & Repair

### 10.1 Object Orgy
**Rozpoznasz gdy**:
- wszystko zna wszystko
- brak „głównego wejścia”

**Przykład**
Moduł `orders` bezpośrednio wywołuje metody `payments`, `shipping` i `notifications`,
przekazując im wewnętrzne obiekty domenowe bez jednego punktu koordynacji.

**Naprawa**:
- wprowadź Facade
- ogranicz widoczność

---

### 10.2 Database as IPC
**Rozpoznasz gdy**:
- status w DB = komunikat
- polling zamiast eventu

**Przykład**
Serwis A zapisuje `status=READY` w tabeli, a serwis B co 5 sekund skanuje bazę,
zamiast otrzymać zdarzenie lub wiadomość.

**Naprawa**:
- jawne zdarzenia
- kolejka lub callback

---

### 10.3 Leaky Abstraction
**Rozpoznasz gdy**:
- użytkownik musi znać „jak działa środek”

**Naprawa**:
- zmień API na intencjonalne
- ukryj szczegóły

---

## 11) Correction Playbook

Gdy granice są złamane:
- wprowadź Facade lub Adapter,
- rozbij odpowiedzialności (SRP),
- odwróć zależność lub ją wytnij,
- przenieś konfigurację poza kod,
- nazwij i udokumentuj granicę.

---

## 12) Boundary Verification (How to Test Boundaries)

Agent powinien pytać:

- Czy da się usunąć implementację bez zmiany kontraktu?
- Czy da się napisać test kontraktu bez mockowania wnętrza?
- Czy zależności da się narysować jako DAG?

Jeśli odpowiedź brzmi „nie” → granica jest fikcją.

---

## 13) Boundary Lifecycle Rules

Granice **nie są wieczne**.

### When to Split
- zmiany są niezależne
- różne tempo rozwoju

### When to Merge
- brak realnej zmienności
- kontrakt jest pusty

### When to Promote
- granica staje się sieciowa
- ownership się rozdziela

---

## 14) Local Tensions

Ta zasada **może zostać świadomie naruszona**, gdy:
- krytyczna wydajność tego wymaga,
- koszt refaktoru przewyższa wartość krótkoterminowo.

Każde naruszenie musi być:
- jawne,
- lokalne,
- odwracalne.

---

## 15) Conflict Resolution with Other Creeds

- **Simplicity vs Boundaries**
  → preferuj prostotę, dopóki nie pojawi się realna zmienność.

- **Form vs Boundaries**
  → struktura ma służyć granicy, nie odwrotnie.

- **Continuity vs Boundaries**
  → granice stabilniejsze niż DRY.

---

## 16) Final Agent Mandate

Jeśli agent widzi:
- nienazwaną granicę,
- niejawny kontrakt,
- zależność „bo tak wyszło”,

ma **obowiązek zatrzymać zmianę**.

Boundary violations are architectural bugs.

---

## 17) Metadata

Owner: Platform / Architecture
Version: 1.2
Applies to: Roles, Tech Agents, System Design
Status: Decision-Enforcing
