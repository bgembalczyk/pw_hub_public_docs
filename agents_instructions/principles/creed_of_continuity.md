# Principle: Creed of Continuity

> Self-contained foundational principle.
> Defines how an agent preserves **long-term consistency, reuse, and evolutionary integrity**.

---

## 1) Identity & Intent

**Name**
`Creed of Continuity`

**Intent**
Chroni system przed erozją w czasie.
Zapobiega duplikacji, rozjazdom wzorców i lokalnym „wynalazkom”,
które niszczą długoterminową utrzymywalność.

Agent stosujący tę zasadę **myśli w kategoriach ewolucji, nie pojedynczego commita**.

---

## 2) Core Decision Rule

> **Jeśli coś już istnieje, nowa zmiana musi się do tego odnieść — nie konkurować z tym.**

Nowa logika:
- rozszerza,
- konsoliduje,
- albo świadomie zastępuje.

Nigdy nie powiela w ciszy.

---

## 3) What This Principle Protects

- jedno źródło prawdy (logika, dane, konfiguracja),
- spójne nazewnictwo domenowe,
- powtarzalne wzorce rozwiązywania problemów,
- możliwość bezpiecznej refaktoryzacji,
- długowieczność interfejsów i usług.

---

## 4) Continuity Obligations (Must)

Agent musi egzekwować ciągłość na **trzech poziomach**.

### 4.1 Source of Truth

- Jedno miejsce **definiuje regułę**, pozostałe ją używają.
- SoT może być:
  - moduł domenowy,
  - kontrakt API,
  - schema danych,
  - centralna konfiguracja.

**Dobry przykład**
Walidacja statusów zamówienia istnieje tylko w module domenowym,
UI i API jedynie ją wywołują.

**Zły przykład**
Ta sama lista statusów:
- w backendzie,
- w frontendzie,
- w migracji.

---

### 4.2 Naming & Patterns

- Jedno pojęcie = jedna nazwa w całym systemie.
- Jeden wzorzec na jeden problem domenowy.

**Dobry przykład**
Wszędzie używane jest `Subscription`, nigdy `Plan` w tej samej domenie.

**Zły przykład**
`UserPlan`, `AccountTier`, `SubscriptionLevel` opisują to samo.

---

### 4.3 Evolution over Duplication

- Preferuj refaktor nad kopiowaniem.
- **Rule of Three** = sygnał konsolidacji, nie automatyczny nakaz.

```
# GOOD (extension)
class PaymentCalculator:
    def calculate(self, context): ...

class DiscountedPaymentCalculator(PaymentCalculator):
    ...
```

```
# BAD (duplication)
def calculate_payment_v1(...): ...
def calculate_payment_v2(...): ...
```

---

## 5) Continuity Decision Procedure (How the Agent Thinks)

Przy każdej zmianie agent pyta:

1. Czy podobna logika już istnieje?
2. Czy nowy kod rozszerza ją, czy konkuruje?
3. Czy da się wskazać jedno „źródło prawdy”?
4. Czy zmiana zmniejsza liczbę miejsc do modyfikacji w przyszłości?

Jeśli nie → naruszenie ciągłości.

---

## 6) Design Heuristics for Change

- **DRY** – duplikacja to dług techniczny.
- **Open–Closed** – stabilne elementy są rozszerzane, nie przepisywane.
- **Loose coupling** – konsolidacja nie może zwiększać sprzężenia.
- **Service longevity** – interfejsy żyją dłużej niż implementacje.

---

## 7) Allowed Tools & Patterns

Stosuj, gdy **realnie zmniejszają liczbę wariantów**:

- Extension Object,
- Visitor (nowe operacje bez zmian struktur),
- Dependency Inversion (stabilizacja kontraktu),
- Facade / Extensibility patterns.

> Narzędzie jest poprawne tylko wtedy, gdy **zmniejsza przyszły koszt zmiany**.

---

## 8) Anti-Patterns (Recognition & Repair)

### 8.1 Duplicate Abstraction

**Rozpoznasz gdy**:
- dwa byty robią „prawie to samo”,
- różnią się tylko szczegółami.

**Przykład**
`InvoiceCalculator` i `BillingCalculator` mają te same kroki,
ale różnią się nazwami metod i jednym parametrem.

**Naprawa**:
- wyodrębnij wspólny rdzeń,
- parametryzuj różnice.

---

### 8.2 Parallel Evolution

**Rozpoznasz gdy**:
- każda zmiana wymaga edycji kilku miejsc,
- zmiany „zawsze idą parami”.

**Przykład**
Nowe pole statusu trzeba dopisywać w API, UI i migracji,
bo każda warstwa ma własną listę statusów.

**Naprawa**:
- wskaż jedno SoT,
- pozostałe uzależnij od niego.

---

### 8.3 Lava Flow

**Rozpoznasz gdy**:
- „nikt nie wie, czy to jeszcze potrzebne”,
- kod istnieje „bo był”.

**Przykład**
Stary moduł `legacy_exporter` jest wywoływany „na wszelki wypadek”,
ale nikt nie potrafi wskazać klienta ani testu, który go potrzebuje.

**Naprawa**:
- usuń,
- albo nazwij i udokumentuj cel.

---

## 9) Failure Modes & Detection

### 9.1 Typowe Patologie
- Unfactored hierarchies.
- Lokalne „frameworki”.
- Restart zamiast refaktoru.

### 9.2 Sygnały Ostrzegawcze
- Trudność w znalezieniu „gdzie to jest”.
- Te same poprawki w wielu miejscach.
- Nowe nazwy dla starych pojęć.

---

## 10) Correction Playbook

Gdy ciągłość została naruszona:
- wskaż źródło prawdy,
- skonsoliduj duplikaty,
- ujednolić nazewnictwo,
- usuń martwy kod,
- opisz zmianę jako **ewolucję**, nie wyjątek.

---

## 11) Local Tensions

Zasada może być chwilowo napięta, gdy:
- szybka poprawka wprowadza duplikację,
- koszt refaktoru jest zbyt wysoki.

Każde odstępstwo musi być:
- jawne,
- tymczasowe,
- zaplanowane do spłaty.

---

## 12) Evolution Rules

### Stable Core
- Jedno źródło prawdy.
- Spójność nazw i wzorców.

### Allowed Evolution
- Konsolidacja.
- Normalizacja.
- Upraszczanie bez zmiany zachowania.

---

## 13) Metadata

Owner: Platform Team
Version: 1.2
Applies to: Roles, Tech Agents, System Design
Status: Decision-Enforcing
