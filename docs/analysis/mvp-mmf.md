# Analiza MVP / MMF — PW_hub  
*Aplikacja Companion dla Politechniki Warszawskiej*

---

## 1. Cel dokumentu

Celem dokumentu jest jednoznaczne określenie:
- **zakresu MVP** systemu PW_hub,
- **inkrementów MMF** po MVP,
- **świadomych decyzji o odroczeniu funkcjonalności**,

w oparciu o istniejącą dokumentację projektową oraz analizy
produktowe, organizacyjne i użytkowe.

Dokument ma charakter **decyzyjny**, nie opisowy.

**Odbiorcy:**
- współwłaściciele produktu (Samorząd Studentów PW, BKiP PW),
- Centrum Informatyzacji PW,
- zespół backend (Django / DRF),
- zespół mobile (Flutter),
- osoby odpowiedzialne za treści i dostępność.

---

## 2. Źródła (source of truth)

Zakres i decyzje w dokumencie wynikają bezpośrednio z:
- `docs/docs.md` — wizja i koncepcja rozwiązania,
- `docs/specs.md` — specyfikacja funkcjonalna,
- Stakeholder Analysis — własność i decyzyjność,
- Analiza JTBD — fundament wartości MVP,
- Problem Statement — definicja problemu,
- User Journey Maps — kluczowe ścieżki użytkowników,
- Context Diagram — granice systemu i integracje.

Dokument **nie wprowadza nowych wymagań**.

---

## 3. Definicje robocze

### MVP — Minimum Viable Product
Minimalny zakres funkcjonalny, który:
- rozwiązuje **najważniejszy problem użytkownika**,
- pozwala na **pilotaż uczelniany**,
- umożliwia **walidację adopcji i wartości**,
- stanowi stabilną bazę do dalszego rozwoju.

### MMF — Minimum Marketable Feature
Samodzielny, kompletny fragment funkcjonalności, który:
- dostarcza użytkownikowi mierzalną wartość,
- może być wdrażany niezależnie,
- rozszerza MVP bez naruszania jego stabilności.

---

## 4. Kontekst produktu (skrót)

- Aplikacja mobilna (Flutter) dla studentów PW.
- Panele webowe (Django DTL) dla:
  - jednostek PW,
  - organizacji studenckich,
  - administratorów merytorycznych.
- Backend: Django + DRF, PostgreSQL.
- System uczelniany, docelowo utrzymywany przez CI PW.

**Zakres domenowy:**
aktualności, wydarzenia, zapisy i wejściówki,
dostępność wydarzeń, publikacja i moderacja treści.

---

## 5. Własność produktu i odpowiedzialności

### Własność produktowa (Product Ownership)
- **Samorząd Studentów PW**  
  — współwłaściciel wizji z perspektywy studentów.
- **Biuro Komunikacji i Promocji PW**  
  — właściciel merytoryczny systemu i treści oficjalnych.

### Własność techniczna
- **Centrum Informatyzacji PW**  
  — architektura, hosting, bezpieczeństwo, integracje.

Model własności jest **współdzielony**, zgodnie z analizą interesariuszy.

---

## 6. Cel MVP (produktowy)

Celem MVP jest sprawdzenie, czy:

> **jedno centralne miejsce publikacji wydarzeń i informacji uczelnianych**
> realnie ułatwia studentom orientację w życiu uczelni
> oraz zwiększa udział w wydarzeniach.

MVP:
- **nie** optymalizuje jeszcze zaangażowania,
- **nie** personalizuje treści,
- **nie** integruje się głęboko z systemami zewnętrznymi.

---

## 7. MVP — zakres funkcjonalny („IN”)

### 7.1 Logowanie i role (SSO)

**User story:**  
Jako student chcę zalogować się kontem uczelnianym,
aby korzystać z aplikacji bez tworzenia nowego konta.

**AC:**
- Logowanie wyłącznie przez CAS USOSweb / Microsoft Entra ID.
- Brak lokalnych haseł.
- Automatyczne przypisanie roli użytkownika.

---

### 7.2 Aktualności (student)

**User story:**  
Jako student chcę przeglądać aktualności uczelniane,
aby szybko sprawdzić, czy coś istotnego mnie dotyczy.

**AC:**
- Lista aktualności w aplikacji mobilnej.
- Filtrowanie po kategorii.
- Treści w języku polskim (EN poza MVP).

---

### 7.3 Wydarzenia (student)

**User story:**  
Jako student chcę przeglądać wydarzenia,
aby zdecydować, w których chcę wziąć udział.

**AC:**
- Lista wydarzeń.
- Podstawowe filtry (kategoria, język).
- Widok szczegółów wydarzenia zawierający:
  - opis,
  - termin,
  - lokalizację,
  - informacje o dostępności
    (architektonicznej, sensorycznej, językowej).

---

### 7.4 Zapisy i wejściówki

**User story:**  
Jako student chcę zapisać się na wydarzenie
i mieć jednoznaczne potwierdzenie udziału.

**AC:**
- Możliwość zapisu i rezygnacji.
- Obsługa limitu miejsc.
- Generowanie wejściówki QR dostępnej w aplikacji.

---

### 7.5 Panel jednostek (Django)

**User story:**  
Jako organizator chcę publikować wydarzenia i aktualności,
aby dotrzeć z informacją do studentów.

**AC:**
- Tworzenie i edycja wydarzeń.
- Zarządzanie zapisami i listą uczestników.
- Publikacja aktualności jednostki.

---

### 7.6 Panel administratora merytorycznego

**User story:**  
Jako administrator chcę moderować treści,
aby zachować spójność i jakość informacji.

**AC:**
- Zarządzanie użytkownikami i rolami.
- Moderacja treści.
- Zarządzanie jednostkami.

---

## 8. MVP — zakres poza zakresem („OUT”)

Świadomie odroczone:
- Mapy kampusu i nawigacja.
- Integracja z USOS (read-only).
- Powiadomienia push i przypomnienia.
- Personalizacja treści.
- Analityka i metryki dla autorów treści.

Odroczenie ≠ rezygnacja.

---

## 9. MMF — inkrementy funkcjonalne

### MMF-1: Informacje i wydarzenia
*(tożsamy z MVP)*

**Wartość:**
- jeden spójny kanał informacyjny,
- walidacja adopcji i JTBD.

---

### MMF-2: Mapy i nawigacja kampusu

**Zakres:**
- mapa kampusu i budynków,
- trasy piesze,
- trasy dostępne.

**Zależności:** dane CENAGIS / GiK.  
**Wartość:** orientacja i dostępność.

---

### MMF-3: Integracja z USOS

**Zakres:**
- dane informacyjne (read-only),
- przypomnienia o terminach.

**Zależności:** API USOS, uzgodnienia bezpieczeństwa.  
**Wartość:** ograniczenie ryzyka przegapienia terminów.

---

### MMF-4: Powiadomienia i personalizacja

**Zakres:**
- powiadomienia push,
- przypomnienia o zapisanych wydarzeniach.

**Wartość:** wzrost zaangażowania i retencji.

---

## 10. Kryteria sukcesu MVP

- liczba aktywnych użytkowników,
- liczba zapisów na wydarzenia,
- liczba aktywnych jednostek publikujących treści,
- retencja po 14 i 30 dniach.

Metryki służą **walidacji wartości**, nie raportowaniu.

---

## 11. Kluczowe ryzyka

- brak adopcji wśród studentów,
- przeciążenie autorów i administratorów treści,
- opóźnienia organizacyjne (SSO, hosting),
- rozrost zakresu poza MVP.

---

## 12. Następne kroki

1. Formalne zatwierdzenie zakresu MVP przez interesariuszy.
2. Budowa backlogu na bazie MMF-1.
3. Przygotowanie pilotażu uczelnianego.
4. Zaplanowanie walidacji kluczowych JTBD.
