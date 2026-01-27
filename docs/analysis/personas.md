# Personas – instrukcja tworzenia i stosowania

> Dokument opisuje **jak poprawnie tworzyć Persony w projekcie**.
> Ma charakter instrukcyjny i może być przekazywany innym osobom
> biorącym udział w analizie, projektowaniu lub rozwoju systemu.
>
> Persony w tym projekcie są narzędziem **decyzyjnym**, nie marketingowym.

---

## 1. Czym jest Persona w tym projekcie

**Persona** to syntetyczny model realnego użytkownika, który:
- reprezentuje **konkretną rolę i dominującą potrzebę**,
- opisuje **cele, problemy i zachowania** w kontekście systemu,
- służy jako **punkt odniesienia przy podejmowaniu decyzji projektowych**.

Persona pomaga odpowiedzieć na pytania:
- dla kogo projektujemy daną funkcję?
- jaki problem użytkownika rozwiązujemy?
- jakie kompromisy są akceptowalne z jego perspektywy?

---

## 2. Czym Persona NIE jest

Persona **nie jest**:
- opisem „średniego użytkownika”,
- profilem demograficznym bez kontekstu użycia,
- zastępstwem backlogu, user stories lub wymagań,
- dokumentem tworzonym wyłącznie „pod prezentację”.

Jeśli Persona nie wpływa na decyzje projektowe — jest zbędna.

---

## 3. Relacja do proto-personas

- **Proto-personas** to hipotezy tworzone na wczesnym etapie projektu.
- **Personas** są ich rozwinięciem, opartym na:
  - wiedzy domenowej,
  - doświadczeniu zespołu,
  - obserwacjach lub częściowej walidacji.

Każda Persona powinna:
- mieć jednoznaczne źródło pochodzenia,
- jasno określony poziom pewności (status walidacji).

---

## 4. Zasady ogólne tworzenia Person

1. **Jedna Persona = jedna dominująca potrzeba / problem**
2. Persony powinny być:
   - krótkie,
   - konkretne,
   - możliwe do przywołania w dyskusji.
3. Skupiamy się na:
   - celach,
   - bólach,
   - zachowaniach,
   - kontekście użycia.
4. Unikamy:
   - biografii,
   - zbędnej demografii,
   - cech bez wpływu na decyzje projektowe.

---

## 5. Sekcje Persony i ich znaczenie

### Rola i kontekst

**Cel sekcji**  
Określenie kim jest dana osoba, jaką pełni rolę w systemie
oraz w jakim kontekście życiowym i uczelnianym funkcjonuje.

Persona powinna być opisana jak **konkretna, realistyczna osoba**,
o której wiemy tyle, ile naturalnie wiedzielibyśmy o realnym użytkowniku.

**Powinna zawierać**
- imię (robocze, realistyczne),
- status na uczelni (np. student, rok studiów, kierunek),
- kontekst funkcjonowania (np. tryb studiów, aktywność),
- sytuacje, w których korzysta z systemu.

**Nie powinna zawierać**
- rozbudowanej historii życia,
- szczegółów bez wpływu na projekt (hobby, cechy osobowości bez znaczenia).

---

### Główna praca użytkownika (Job To Be Done)

**Cel sekcji**  
Zdefiniowanie jednej, dominującej potrzeby,
która realnie motywuje tę osobę do korzystania z systemu.

**Powinna zawierać**
- jedno jasno sformułowane zdanie opisujące „pracę” użytkownika,
- perspektywę użytkownika, nie systemu,
- formułę typu:
  > „Gdy … chcę … aby …”

**Nie powinna zawierać**
- opisu funkcji aplikacji,
- wielu różnych potrzeb naraz.

---

### Cele użytkownika

**Cel sekcji**  
Pokazanie, co dla tej osoby oznacza sukces
i po co w ogóle sięga po rozwiązanie.

**Powinna zawierać**
- 2–4 konkretne cele,
- cele opisane językiem użytkownika,
- cele osadzone w jego codziennym kontekście studenckim.

**Nie powinna zawierać**
- celów organizacji lub zespołu projektowego,
- ogólników typu „chce korzystać z aplikacji”.

---

### Bóle i frustracje

**Cel sekcji**  
Ujawnienie realnych problemów,
które ta osoba doświadcza dziś bez rozwiązania.

**Powinna zawierać**
- konkretne trudności z perspektywy użytkownika,
- skutki tych problemów (czas, stres, chaos, niepewność),
- problemy wynikające z rzeczywistego kontekstu uczelni.

**Nie powinna zawierać**
- opisów problemów technicznych systemów,
- listy oczekiwanych funkcji.

---

### Zachowania i nawyki

**Cel sekcji**  
Opisanie, jak ta osoba faktycznie działa na co dzień,
a nie jak „powinna” działać w idealnym świecie.

**Powinna zawierać**
- jak często sprawdza informacje,
- z jakich urządzeń i kanałów korzysta,
- jak podejmuje decyzję, czy coś jest dla niej ważne.

**Nie powinna zawierać**
- idealizowanych lub życzeniowych zachowań,
- sprzeczności z obserwowaną rzeczywistością.

---

### Ograniczenia i potrzeby szczególne

**Cel sekcji**  
Uświadomienie ograniczeń, które realnie wpływają
na sposób korzystania z systemu.

**Powinna zawierać**
- ograniczenia czasowe i uwagowe,
- bariery językowe, poznawcze lub dostępnościowe (jeśli dotyczy),
- ograniczenia organizacyjne wynikające z realiów uczelni.

---

### Kryteria sukcesu

**Cel sekcji**  
Określenie, po czym ta konkretna osoba uzna,
że rozwiązanie działa i jest dla niej wartościowe.

**Powinna zawierać**
- subiektywne mierniki sukcesu (np. szybciej, bez szukania),
- efekty odczuwalne bezpośrednio przez użytkownika.

**Nie powinna zawierać**
- metryk technicznych lub biznesowych.

---

### Scenariusz referencyjny

**Cel sekcji**  
Osadzenie Persony w jednej,
typowej i realistycznej sytuacji użycia.

**Powinna zawierać**
- krótki opis konkretnej sytuacji z życia studenta,
- jeden dominujący kontekst (czas, miejsce, cel).

**Nie powinna zawierać**
- pełnych user flow,
- przypadków skrajnych lub wyjątkowych.

---

### Implikacje projektowe

**Cel sekcji**  
Bezpośrednie przełożenie Persony na decyzje projektowe.

**Powinna zawierać**
- jakie wymagania ta Persona narzuca projektowi,
- jakie kompromisy są konieczne,
- z czego można świadomie zrezygnować,
  aby nie przeciążyć użytkownika.

Ta sekcja jest kluczowa dla podejmowania decyzji
dotyczących zakresu i priorytetów projektu.

---

## 6. Status i walidacja

Każda Persona powinna mieć jawnie określony status:
- **Validated** – oparta na badaniach / testach,
- **Partially validated** – częściowo potwierdzona,
- **Assumption-based** – oparta głównie na wiedzy domenowej.

Status może zmieniać się w trakcie projektu.

---

## 7. Dobre praktyki

- Maksymalnie **3–5 Person** na projekt.
- Jedna Persona powinna być **Primary (kanoniczna)**.
- Każda istotna funkcja powinna dać się uzasadnić pytaniem:
  > „Której Personie to pomaga?”
- Persony są dokumentami **żywymi**, aktualizowanymi iteracyjnie.

---

## 8. Cel dokumentu

Celem dokumentu jest:
- ujednolicenie sposobu tworzenia Person,
- umożliwienie przekazania pracy innym osobom,
- zapewnienie spójności między analizą a projektowaniem,
- ograniczenie decyzji opartych wyłącznie na intuicji.

Dokument nie zastępuje badań,
ale umożliwia ich świadome wykorzystanie i interpretację.
