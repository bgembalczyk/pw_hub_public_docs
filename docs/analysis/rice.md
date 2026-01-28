# Analiza RICE — PW_hub (priorytety inicjatyw MVP)


## 1. Rola dokumentu

Dokument przedstawia **analizę RICE** dla kluczowych inicjatyw funkcjonalnych
projektu **PW_hub** na etapie **MVP**.

Celem analizy jest:

- uszeregowanie **kolejności realizacji inicjatyw**,
- uwzględnienie jednocześnie:
    - wartości dla użytkownika,
    - zasięgu,
    - pewności założeń,
    - kosztu realizacji,
- wsparcie decyzji backlogowych **po** analizach:
    - Opportunity Scoring,
    - MoSCoW.

RICE w tym dokumencie:

- **nie definiuje zakresu MVP** (robi to MoSCoW),
- **nie identyfikuje problemów użytkownika** (robi to Opportunity),
- służy do ustalenia **co realizujemy wcześniej, a co później w MVP**.


## 2. Kontekst decyzyjny

Zgodnie z wcześniejszymi decyzjami projektu:

- moduł `events` jest **jedynym modułem write-enabled** w MVP,
- pozostałe moduły (aktualności, guides) są **read-only**,
- MVP koncentruje się na:
    - orientacji informacyjnej,
    - wydarzeniach i udziale w nich.

Analiza RICE dotyczy **inicjatyw funkcjonalnych**, a nie pojedynczych ekranów
czy elementów UI.


## 3. Źródła (Source of Truth)

- `docs/specs.md` — specyfikacja funkcjonalna (sekcja 3.x)
- Opportunity Scoring — analiza (Ulwick)
- Analiza MoSCoW — PW_hub (MVP)
- Non-Goals
- ADR: Events jako jedyny moduł interaktywny


## 4. Metodyka RICE

### Składniki

- **Reach** — liczba użytkowników, którzy realnie skorzystają z inicjatywy
  w okresie **1 miesiąca**.
- **Impact** — wpływ na realizację kluczowych JTBD (skala 0.25–3.0).
- **Confidence** — pewność szacunków (0–1).
- **Effort** — szacowany wysiłek realizacji (osobo-miesiące).

**Wzór:**

```
RICE = (Reach × Impact × Confidence) / Effort
```

### Status danych

> Wszystkie wartości liczbowe oznaczono jako **ASSUMPTION**  
> (brak danych MAU/DAU i finalnych estymat inżynierskich).
> Analiza służy do **porównania względnego**, nie do predykcji absolutnej.


## 5. Zakres analizowanych inicjatyw

Inicjatywy pochodzą bezpośrednio z `docs/specs.md` (sekcja 3.x)
i zostały zagregowane do poziomu sensownego dla analizy RICE.

Ze względu na **realia wdrożeniowe dużej uczelni publicznej**:

- dodanie aplikacji do ekosystemu PW,
- uzyskanie dostępu do logowania przez **USOSweb (CAS)** lub **Microsoft Entra ID**,

wymagają aplikacji **funkcjonalnie kompletnej i stabilnej**.
Oznacza to, że **pierwszy prototyp (pre-MVP)** musi zawierać
praktycznie cały docelowy zakres funkcjonalny **z wyłączeniem SSO**.

W konsekwencji:

- **SSO nie jest traktowane jako inicjatywa wczesnego prototypowania**,
- SSO stanowi **krok formalno-integracyjny przed MVP produkcyjnym**,
- analiza RICE porządkuje kolejność prac **w obrębie kompletnego rozwiązania**,
  a nie „od zera”.

Zakres analizowanych inicjatyw obejmuje:

- Konsumpcję treści (aktualności)
- Odkrywanie wydarzeń
- Udział w wydarzeniach (zapisy)
- Obsługę wejścia na wydarzenia (wejściówki)
- Logowanie i identyfikację użytkownika (SSO) — jako etap finalny przed MVP


## 6. Tabela RICE (ASSUMPTION)

| Inicjatywa                                  | Reach (mies.) | Impact | Confidence | Effort (os-mies.) |     RICE | Uzasadnienie                                                                 |
|---------------------------------------------|--------------:|-------:|-----------:|------------------:|---------:|------------------------------------------------------------------------------|
| **System aktualności**                      |          2000 |    1.5 |        0.7 |               1.5 | **1400** | Najszybsza dostarczalna wartość informacyjna; podstawa prototypu             |
| **Odkrywanie wydarzeń (lista + szczegóły)** |          1500 |    2.0 |        0.6 |               2.5 |  **720** | Kluczowe dla realizacji JTBD „orientacja + aktywność”                        |
| **Zapisy na wydarzenia**                    |           800 |    2.5 |        0.6 |               2.0 |  **600** | Najważniejsza funkcja interaktywna; rdzeń wartości MVP                       |
| **Wejściówki (QR)**                         |           400 |    1.5 |        0.5 |               1.5 |  **200** | Funkcja wtórna, ale wymagana do realnych testów wydarzeń                     |
| **Logowanie SSO**                           |          3000 |    3.0 |        0.7 |               2.0 | **3150** | Wymóg formalny przed MVP; integracja możliwa dopiero po stabilizacji systemu |


## 7. Ranking inicjatyw (z uwzględnieniem realiów wdrożeniowych)

**Faza prototypowa (pre-MVP):**

1. **System aktualności**
2. **Odkrywanie wydarzeń**
3. **Zapisy na wydarzenia**
4. **Wejściówki QR**

**Faza przejścia do MVP produkcyjnego:**

5. **Logowanie SSO**


## 8. Interpretacja wyników

- **SSO** ma najwyższy wynik RICE,
  ale **nie jest inicjatywą startową** — jest:
    - formalnym warunkiem wejścia do ekosystemu PW,
    - możliwym do realizacji dopiero po stabilizacji funkcjonalnej aplikacji.
- **System aktualności i wydarzenia** muszą istnieć w pełnym zakresie
  już na etapie prototypu, aby:
    - umożliwić realne testy,
    - zebrać feedback użytkowników i interesariuszy,
    - uzasadnić integrację SSO po stronie uczelni.
- RICE w tym kontekście:
    - **nie determinuje kolejności „od zera”**,
    - lecz **porządkuje sensowną sekwencję dojrzewania produktu**.


## 9. Spójność z innymi decyzjami

- Opportunity Scoring → wskazuje **gdzie jest wartość**
- MoSCoW → definiuje **co musi istnieć w MVP**
- RICE → porządkuje **kolejność stabilizacji funkcjonalności**
- ADR → utrwalają decyzje trudne do cofnięcia (np. SSO jako etap końcowy)

RICE **nie zmienia zakresu MVP**, a jedynie dostosowuje jego realizację
do realiów organizacyjnych PW.


## 10. Ryzyka i ograniczenia

- Konieczność utrzymania alternatywnego mechanizmu dostępu
  (np. konta techniczne / tryb demonstracyjny) przed SSO.
- Opóźnienia formalne po stronie integracji uczelnianych.
- Brak danych adopcyjnych przed uruchomieniem SSO.

Ryzyka te są **nieuniknione i akceptowane** w modelu uczelnianym.


## 11. Dalsze kroki

1. Zaprojektować **tryb pre-SSO** (demo / konta testowe).
2. Zrealizować kompletny prototyp funkcjonalny.
3. Zebrać feedback interesariuszy PW.
4. Uruchomić proces integracji SSO jako krok przed MVP produkcyjnym.


**Status:** wersja robocza (ASSUMPTION)  
**Zakres:** prototyp → MVP PW_hub  
**Charakter:** dokument decyzyjny (priorytetyzacja)
