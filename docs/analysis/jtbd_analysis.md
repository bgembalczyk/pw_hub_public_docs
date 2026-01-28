# Analiza Jobs To Be Done (JTBD) — PW_hub

## 1. Kontekst i cel
PW_hub to aplikacja informacyjna tworzona przez studentów dla studentów Politechniki Warszawskiej.  
Celem analizy Jobs To Be Done (JTBD) jest zrozumienie **realnych prac (jobs)**, jakie użytkownicy próbują wykonać w swoim życiu studenckim — niezależnie od technologii czy konkretnego interfejsu — aby świadomie projektować zakres, priorytety i MVP produktu.

JTBD stanowią **punkt odniesienia dla decyzji produktowych**, a nie listę funkcjonalności.

---

## 2. Założenia i zakres
- Analiza dotyczy **pozadydaktycznego funkcjonowania studentów PW**:
  - wydarzenia,
  - ogłoszenia,
  - inicjatywy studenckie,
  - zasoby i usługi uczelniane.
- Nie opisujemy:
  - rozwiązań technicznych,
  - UI,
  - architektury systemu.
- JTBD są **niezależne od sposobu realizacji** (aplikacja mobilna to tylko jedno z możliwych rozwiązań).
- Jeśli produkt ma wspierać inne grupy (np. twórców treści, administrację), ich JTBD są opisane jako **odrębne segmenty**, a nie „role systemowe”.

---

## 3. Segmenty użytkowników (hipotezy robocze)

### 3.1 Studenci studiów I i II stopnia
Studenci aktywnie uczestniczący w życiu uczelni, potrzebujący bieżącej orientacji w wydarzeniach, terminach i możliwościach rozwoju.

### 3.2 Studenci pierwszego roku
Studenci w fazie adaptacji, potrzebujący jasnych wskazówek, gdzie i jak załatwia się podstawowe sprawy oraz co dzieje się na uczelni poza zajęciami.

### 3.3 Studenci aktywni organizacyjnie (twórcy treści)
Członkowie samorządu, kół naukowych i organizacji studenckich, odpowiedzialni za publikowanie i promowanie wydarzeń oraz inicjatyw.

> Uwaga: to **osobny segment JTBD**, a nie tylko „administratorzy systemu”.

---

## 4. Główne jobs (poziom wysokopoziomowy)

1. **Zorientować się, co istotnego dzieje się na uczelni w danym momencie.**
2. **Nie przegapić ważnych terminów i okazji.**
3. **Szybko znaleźć właściwe informacje i zasoby uczelniane.**
4. **Aktywnie uczestniczyć w życiu uczelni lub je współtworzyć.**

Te jobs są **stabilne w czasie** i nie zależą od konkretnej formy rozwiązania.

---

## 5. Job Stories (JTBD)

Format:
> **Kiedy** [kontekst / sytuacja],  
> **chcę** [wykonać pracę],  
> **aby** [osiągnąć mierzalny lub odczuwalny rezultat].

### 5.1 Orientacja i informacja

- **Kiedy** mam krótki czas między zajęciami,  
  **chcę** szybko zorientować się, co ważnego dzieje się na uczelni,  
  **aby** nie przegapić istotnych wydarzeń lub terminów.

- **Kiedy** zbliża się okres wzmożonych obowiązków (sesja, zapisy, rekrutacje),  
  **chcę** widzieć kluczowe informacje w jednym miejscu,  
  **aby** ograniczyć chaos informacyjny i stres.

---

### 5.2 Nawigacja po zasobach uczelni

- **Kiedy** muszę załatwić sprawę administracyjną lub organizacyjną,  
  **chcę** szybko znaleźć właściwą procedurę, miejsce lub kontakt,  
  **aby** rozwiązać problem bez szukania informacji w wielu źródłach.

- **Kiedy** dopiero zaczynam studia,  
  **chcę** mieć jasny zestaw podstawowych informacji i zasobów,  
  **aby** poczuć się pewniej i samodzielnie funkcjonować na uczelni.

---

### 5.3 Zaangażowanie i życie studenckie

- **Kiedy** szukam aktywności poza zajęciami,  
  **chcę** mieć przegląd dostępnych inicjatyw studenckich,  
  **aby** wybrać te, które są zgodne z moimi zainteresowaniami.

- **Kiedy** organizuję wydarzenie lub inicjatywę,  
  **chcę** dotrzeć z informacją do studentów, których to faktycznie interesuje,  
  **aby** zwiększyć zaangażowanie i frekwencję.

---

### 5.4 Ograniczenie szumu informacyjnego

- **Kiedy** jestem przytłoczony nadmiarem komunikatów,  
  **chcę** widzieć tylko treści dla mnie istotne,  
  **aby** nie tracić czasu i uwagi na niepotrzebne informacje.

---

## 6. Jobs emocjonalne i społeczne (cross-cutting)

- **Poczucie bycia na bieżąco**  
  „Nic ważnego mnie nie omija”.

- **Poczucie przynależności**  
  „Jestem częścią życia uczelni, nie tylko odbiorcą zajęć”.

- **Poczucie kontroli i sprawczości**  
  „Wiem, co się dzieje i potrafię zaplanować swoje działania”.

---

## 7. Outcomes — kryteria sukcesu jobów

Job uznajemy za wykonany, gdy użytkownik:

- znajduje potrzebną informację w krótkim czasie,
- nie musi szukać jej w wielu źródłach,
- czuje się poinformowany i spokojny co do swoich obowiązków.

### Wskaźniki sukcesu (KPI - ADR-003):
- **Event Signup Conversion Rate** — walidacja joba „udział w wydarzeniach”,
- **Weekly Active Devices (WAD)** — walidacja joba „orientacja informacyjna”,
- **30-Day Retention** — walidacja joba „poczucie bycia na bieżąco”.

Dodatkowe wskaźniki (jakościowe/badawcze):
- skrócenie czasu dotarcia do informacji,
- spadek liczby powtarzalnych pytań informacyjnych.

---

## 8. Bariery i ryzyka (z perspektywy JTBD)

- Rozproszenie źródeł informacji.
- Brak aktualności lub niska jakość treści.
- Nadmiar komunikatów bez hierarchii ważności.
- Brak jasnej odpowiedzialności za publikowane informacje.

---

## 9. Hipotezy do weryfikacji

- Studenci chcą mieć **jedno główne miejsce orientacji informacyjnej**.
- Największą wartość mają informacje „tu i teraz”, a nie archiwalne.
- Dobrze dopasowane treści zwiększają zaangażowanie i powroty.
- Twórcy treści potrzebują prostego sposobu dotarcia do właściwej grupy odbiorców.

---

## 10. Non-goals (na obecnym etapie)

- Zaawansowane systemy rekomendacyjne bez potwierdzonej potrzeby.
- Pełne integracje z systemami uczelni bez jasnego JTBD.
- Rozwiązania wymagające skomplikowanej konfiguracji po stronie użytkownika.

---

## 11. Następne kroki

1. Zweryfikować JTBD i segmenty z kluczowymi interesariuszami.
2. Wybrać **1–2 najważniejsze jobs** jako fundament MVP.
3. Powiązać JTBD z backlogiem i kryteriami akceptacji.
4. Odrzucać lub odkładać funkcje, które nie wspierają kluczowych jobów.
