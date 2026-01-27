# Assumption Mapping — PW_hub

## Cel

Ustrukturyzować i uświadomić kluczowe **założenia (assumptions)** stojące za produktem i wdrożeniem PW_hub, aby:

- zidentyfikować **najwyższe ryzyka produktowe i organizacyjne**,
- zaplanować **działania walidacyjne**,
- utrzymać **kontrolowany zakres MVP**.

Dokument opisuje to, co **zakładamy, ale jeszcze nie wiemy**, a co ma istotny wpływ na sukces projektu.

---

## Zakres

Dokument obejmuje założenia:

- produktowe i użytkowe,
- UX i adopcyjne,
- techniczne i architektoniczne,
- operacyjne, procesowe i organizacyjne,

na poziomie **systemu PW_hub** oraz **procesu jego dostarczania i utrzymania**.

---

## Metoda

Assumption Mapping w układzie **Wpływ (Impact)** × **Pewność (Certainty)**.

- **High Impact / Low Certainty** → krytyczne hipotezy do natychmiastowej walidacji
- **High Impact / High Certainty** → stabilne filary rozwiązania
- **Low Impact / Low Certainty** → obserwować, nie blokują decyzji
- **Low Impact / High Certainty** → detale operacyjne

---

## Lista założeń (Assumptions)

|  ID | Założenie (hipoteza)                                                       | Wpływ  | Pewność | Kategoria                |
|----:|----------------------------------------------------------------------------|:------:|:-------:|--------------------------|
|  A1 | Użytkownicy docelowi chcą korzystać z jednego centralnego narzędzia PW_hub | Wysoki |  Niska  | Produkt / Użytkownicy    |
|  A2 | Głównym problemem użytkowników jest rozproszenie informacji i procesów     | Wysoki |  Niska  | Problem / Produkt        |
|  A3 | Minimalny zestaw funkcji MVP wystarczy do dostarczenia realnej wartości    | Wysoki | Średnia | Zakres / MVP             |
|  A4 | Integracje z istniejącymi narzędziami są warunkiem adopcji                 | Wysoki |  Niska  | Integracje               |
|  A5 | Zespół jest w stanie utrzymać wymagane tempo aktualizacji i reakcji        | Wysoki | Średnia | Operacje                 |
|  A6 | Kluczowe przepływy użytkownika są zrozumiałe bez szkoleń                   | Wysoki |  Niska  | UX                       |
|  A7 | Aktualna architektura umożliwia skalowanie liczby użytkowników             | Wysoki | Średnia | Techniczne               |
|  A8 | Obecne podejście do bezpieczeństwa spełnia wymagania organizacyjne         | Wysoki | Średnia | Bezpieczeństwo           |
|  A9 | Dokumentacja wystarczy do onboardingu nowych członków zespołu              | Średni |  Niska  | Dokumentacja             |
| A10 | Aktualny proces CI/CD nie ogranicza iteracji produktowej                   | Średni | Średnia | DevOps                   |
| A11 | Wymagania prawne i compliance pozostaną stabilne przez 6–12 miesięcy       | Średni |  Niska  | Compliance               |
| A12 | Obecne zasoby infrastruktury wystarczą bez kosztownej optymalizacji        | Średni | Średnia | Koszty                   |
| A13 | Użytkownicy zaakceptują obecny model ról i uprawnień                       | Wysoki |  Niska  | Produkt / Bezpieczeństwo |
| A14 | Zespół akceptuje jednolity model wprowadzania zmian                        | Średni | Średnia | Proces                   |
| A15 | Jakość danych da się utrzymać bez dodatkowych narzędzi                     | Średni |  Niska  | Dane                     |

---

## Macierz Assumption Mapping (Impact × Certainty)

|                          | **Niska pewność**                                 | **Wysoka / średnia pewność**                 |
|--------------------------|---------------------------------------------------|----------------------------------------------|
| **Wysoki wpływ**         | 🔴 **Krytyczne hipotezy**<br/>A1, A2, A4, A6, A13 | 🟡 **Filary rozwiązania**<br/>A3, A5, A7, A8 |
| **Średni / niski wpływ** | ⚪ **Obserwować**<br/>A9, A11, A15                 | 🟢 **Operacyjne detale**<br/>A10, A12, A14   |

> **Fokus walidacyjny projektu powinien koncentrować się na czerwonym polu.**

---

## Szczegóły założeń i plan walidacji

### High Impact / Low Certainty — priorytet walidacji

#### A1 — Centralne narzędzie

- **Ryzyko:** niska adopcja, brak product–problem fit
- **Walidacja:** 5–10 wywiadów użytkowników, analiza alternatywnych narzędzi

#### A2 — Definicja problemu

- **Ryzyko:** błędnie zdefiniowany problem → źle dobrane MVP
- **Walidacja:** analiza FAQ, zgłoszeń, warsztat problem framing

#### A4 — Integracje

- **Ryzyko:** brak integracji blokuje wdrożenie organizacyjne
- **Walidacja:** lista must-have + PoC 1–2 integracji

#### A6 — Samowyjaśniający UX

- **Ryzyko:** kosztowny onboarding, opór użytkowników
- **Walidacja:** testy użyteczności, time-to-first-success

#### A13 — Role i uprawnienia

- **Ryzyko:** blokada wdrożenia przez polityki organizacyjne
- **Walidacja:** review z właścicielem bezpieczeństwa i compliance

---

### High Impact / Medium Certainty — filary rozwiązania

- **A3:** walidacja zakresu MVP (beta users)
- **A5:** przegląd planu utrzymania i obciążenia zespołu
- **A7:** testy obciążeniowe + review architektury
- **A8:** checklisty bezpieczeństwa i audyt wewnętrzny

---

### Medium / Low Impact — monitoring

Założenia: A9–A12, A14, A15  
Walidowane oportunistycznie, bez blokowania decyzji MVP.

---

## Następne kroki

1. Wybrać **3–5 założeń z czerwonej ćwiartki** do walidacji w najbliższym sprincie.
2. Przypisać **właścicieli walidacji** (Product / Tech / Compliance).
3. Utworzyć **backlog walidacyjny** (badania, PoC, testy).
4. Aktualizować mapę po każdej istotnej decyzji produktowej.

---

## Status

- **Data utworzenia:** 2025-01-01
- **Właściciel:** Product + Tech
- **Wersja:** 1.1
- **Źródła:** decyzje projektowe, wywiady (do uzupełnienia)
