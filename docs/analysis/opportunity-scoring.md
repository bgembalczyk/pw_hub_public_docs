# Opportunity Scoring — analiza (Ulwick)

**PW Hub (Aplikacja Companion PW)**

---

## 1. Rola dokumentu

Dokument przedstawia **analizę Opportunity Scoring** dla projektu **PW Hub**
w celu identyfikacji i uszeregowania **najważniejszych okazji produktowych**
na etapie **MVP**.

Analiza:

- opiera się na potrzebach użytkowników (outcomes) wynikających z JTBD,
- wskazuje obszary o **największej luce wartości**,
- stanowi **wejście decyzyjne** do:
    - analizy MoSCoW,
    - definiowania zakresu MVP,
    - utrwalania decyzji w ADR.

Dokument **nie opisuje rozwiązań ani backlogu**.

---

## 2. Kontekst analizy

PW Hub jest aplikacją companion dla studentów Politechniki Warszawskiej,
której głównym problemem do rozwiązania jest:

> rozproszenie informacji uczelnianych oraz trudność w orientacji
> w wydarzeniach i inicjatywach skierowanych do studentów.

Z analizy:

- Problem Statement,
- JTBD,
- User Journey Map,

wynika, że **największa wartość dla użytkownika końcowego**
koncentruje się wokół:

- szybkiej orientacji informacyjnej,
- wydarzeń i udziału w nich,
- planowania krótkoterminowego (dzień / tydzień).

---

## 3. Zakres analizy

Analiza dotyczy:

- **studentów PW** jako użytkowników aplikacji mobilnej,
- potrzeb związanych z:
    - konsumowaniem informacji,
    - wydarzeniami (jedyny moduł interaktywny w MVP).

Poza zakresem:

- potrzeby organizatorów i administratorów,
- funkcje wykraczające poza MVP (zgodnie z Non-Goals),
- optymalizacje techniczne bez bezpośredniej wartości użytkowej.

---

## 4. Źródła danych

Opportunity Scoring oparto na następujących artefaktach projektu:

- Problem Statement — PW Hub
- Analiza JTBD
- Proto-Personas / Personas
- User Journey Map — Student
- MVP / MMF
- Non-Goals

Analiza **porządkuje istniejące potrzeby** i nie wprowadza nowych.

---

## 5. Metryka Opportunity Scoring

Dla każdego outcome’u oceniono:

- **Importance (I)** — jak ważny jest dany outcome,
- **Satisfaction (S)** — jak dobrze jest dziś realizowany.

Zastosowany wzór (Ulwick):

```
OS = I + max(I − S, 0)
```

---

## 6. Zidentyfikowane outcome’y i scoring

| ID   | Outcome (potrzeba użytkownika)                                      | I | S | OS |
|------|---------------------------------------------------------------------|---|---|----|
| O-01 | Szybko sprawdzić, czy dziś jest coś, co mnie dotyczy                | 9 | 3 | 15 |
| O-02 | Zapisać się na wydarzenie bez zbędnych formalności                  | 8 | 5 | 11 |
| O-03 | Wiedzieć, czy wydarzenie jest dla mnie dostępne (język, dostępność) | 8 | 4 | 12 |
| O-04 | Zaplanować tydzień pod kątem wydarzeń uczelnianych                  | 7 | 6 | 8  |
| O-05 | Bezproblemowo wejść na wydarzenie po zapisie                        | 8 | 5 | 11 |
| O-06 | Zadawać pytania organizatorowi wydarzenia                           | 6 | 6 | 6  |
| O-07 | Otrzymywać powiadomienia o istotnych zmianach                       | 7 | 6 | 8  |

---

## 7. Interpretacja wyników

### Silne okazje (OS ≥ 11)

- **O-01:** Szybka orientacja informacyjna
- **O-02:** Zapisy na wydarzenia
- **O-03:** Jasna informacja o dostępności wydarzeń
- **O-05:** Wejście na wydarzenie bez tarcia (QR)

Te outcome’y:

- mają wysoką ważność,
- są słabo lub średnio obsłużone obecnie,
- bezpośrednio wspierają kluczowe JTBD projektu.

### Umiarkowane okazje (OS 8–10)

- **O-04:** Planowanie tygodnia
- **O-07:** Powiadomienia o zmianach

Stanowią wartość uzupełniającą, ale **nie są krytyczne dla MVP**.

### Niskie okazje (OS < 8)

- **O-06:** Q&A do wydarzeń

Brak wyraźnej luki wartości na etapie MVP.

---

## 8. Wnioski decyzyjne

1. Zakres MVP powinien koncentrować się na:
    - orientacji informacyjnej,
    - wydarzeniach jako jedynym module interaktywnym,
    - zapisie i obsłudze uczestnictwa.

2. Outcome’y o najwyższym OS:
    - trafiają do **Must / Should** w analizie MoSCoW,
    - stanowią podstawę decyzji architektonicznych (ADR).

3. Outcome’y o niskim OS:
    - nie są rozwijane w MVP,
    - pozostają w backlogu jako potencjalne rozszerzenia MMF.

---

## 9. Powiązanie z innymi artefaktami

- Opportunity Scoring → identyfikuje **gdzie jest wartość**
- MoSCoW → decyduje **co dowozimy w MVP**
- ADR → utrwala **dlaczego taki zakres**
- Acceptance Criteria → definiują **jak rozpoznamy sukces**

---

## 10. Status dokumentu

- **Właściciel:** Product / PM
- **Status:** obowiązujący dla etapu MVP
- **Charakter:** dokument decyzyjny
- **Aktualizacja:** przy zmianie celu etapu lub istotnym feedbacku z użycia
