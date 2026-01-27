# Mock-upy Aplikacji Mobilnej Flutter / Flutter Mobile App Mock-ups

## 🇵🇱 Po Polsku

### Zakres Mock-upów

**Wszystkie pliki HTML w tym katalogu (`docs/mock/`) przedstawiają mock-upy aplikacji mobilnej Flutter przeznaczonej dla użytkownika końcowego - studenta.**

### Przeznaczenie
- **Platforma**: Flutter (Android + iOS)
- **Grupa docelowa**: Studenci Politechniki Warszawskiej
- **Typ interfejsu**: Aplikacja mobilna
- **Format**: HTML/CSS (mockupy statyczne)

### Zawartość Katalogu

```
docs/mock/
├── README.md           # Ten plik
├── index.html          # Strona główna - spis wszystkich mock-upów
├── home.html           # Ekran główny aplikacji
├── news.html           # Lista aktualności
├── all_news.html       # Wszystkie aktualności
├── events.html         # Lista wydarzeń
├── all_events.html     # Wszystkie wydarzenia
├── event-details.html  # Szczegóły wydarzenia
├── event-ticket.html   # Cyfrowa wejściówka na wydarzenie
├── guides.html         # Poradniki dla studentów
├── map.html            # Mapy kampusu
├── map-card.html       # Karta mapy
├── dark.html           # Tryb ciemny
├── eng.html            # Wersja angielska
├── kontrast.html       # Tryb wysokiego kontrastu
├── all.html            # Widok kompletny
└── assets/             # Zasoby graficzne (obrazy, ikony)
    ├── qr.png          # Przykładowy kod QR
    └── sc.png          # Screenshot
```

### Funkcjonalności Przedstawione w Mock-upach

#### Widoki Główne
- **home.html**: Strona główna z kafelkami nawigacyjnymi
- **news.html**: Strumień aktualności z filtrowaniem
- **events.html**: Kalendarz i lista wydarzeń

#### Szczegóły i Interakcje
- **event-details.html**: Pełne informacje o wydarzeniu, w tym:
  - Opis i lokalizacja
  - Informacje o dostępności
  - Opcje zapisu na wydarzenie
- **event-ticket.html**: Cyfrowa wejściówka z kodem QR

#### Dodatkowe Funkcje
- **guides.html**: Poradniki i przewodniki dla studentów
- **map.html**: Nawigacja po kampusie

#### Dostępność i Lokalizacja
- **dark.html**: Wersja z ciemnym motywem
- **kontrast.html**: Wersja z wysokim kontrastem
- **eng.html**: Wersja w języku angielskim

### Dostępność (WCAG 2.1)

Mock-upy uwzględniają wymagania dostępności:
- ✅ Tryb ciemny
- ✅ Wysoki kontrast
- ✅ Wielojęzyczność (PL/EN)
- ✅ Czytelne czcionki
- ✅ Intuicyjna nawigacja

### Jak Przeglądać Mock-upy

1. Otwórz `index.html` w przeglądarce
2. Nawiguj po dostępnych widokach
3. Testuj różne tryby (ciemny, kontrast, język)

### ⚠️ Czego NIE MA w tym Katalogu

**Mock-upy paneli administracyjnych Django NIE znajdują się tutaj.**

Panele dla:
- Jednostek organizacyjnych
- Administratorów merytorycznych

Są planowane jako osobne interfejsy webowe Django (DTL) i będą udokumentowane w:
- **Dokumentacja**: [`docs/MOCKUPY.md`](../MOCKUPY.md)
- **Przyszłe mock-upy**: `docs/mock_django/` (format PlantUML salt)

### Architektura Techniczna

```
┌─────────────────────────────────┐
│  Aplikacja Flutter (Student)    │
│                                  │
│  - Android                       │
│  - iOS                           │
│  - Mock-upy: docs/mock/ (HTML)   │
└─────────────────────────────────┘
           ↓
    REST API (DRF)
           ↓
┌─────────────────────────────────┐
│     Backend Django + DB         │
└─────────────────────────────────┘
```

---

## 🇬🇧 In English

### Scope of Mock-ups

**All HTML files in this directory (`docs/mock/`) represent mock-ups of the Flutter mobile application intended for the end user - the student.**

### Purpose
- **Platform**: Flutter (Android + iOS)
- **Target audience**: Students of Warsaw University of Technology
- **Interface type**: Mobile application
- **Format**: HTML/CSS (static mockups)

### Directory Contents

```
docs/mock/
├── README.md           # This file
├── index.html          # Homepage - list of all mock-ups
├── home.html           # App home screen
├── news.html           # News list
├── all_news.html       # All news
├── events.html         # Events list
├── all_events.html     # All events
├── event-details.html  # Event details
├── event-ticket.html   # Digital event ticket
├── guides.html         # Student guides
├── map.html            # Campus maps
├── map-card.html       # Map card
├── dark.html           # Dark mode
├── eng.html            # English version
├── kontrast.html       # High contrast mode
├── all.html            # Complete view
└── assets/             # Graphic resources (images, icons)
    ├── qr.png          # Sample QR code
    └── sc.png          # Screenshot
```

### Features Presented in Mock-ups

#### Main Views
- **home.html**: Homepage with navigation tiles
- **news.html**: News stream with filtering
- **events.html**: Calendar and events list

#### Details and Interactions
- **event-details.html**: Complete event information, including:
  - Description and location
  - Accessibility information
  - Event registration options
- **event-ticket.html**: Digital ticket with QR code

#### Additional Features
- **guides.html**: Guides and tutorials for students
- **map.html**: Campus navigation

#### Accessibility and Localization
- **dark.html**: Dark theme version
- **kontrast.html**: High contrast version
- **eng.html**: English language version

### Accessibility (WCAG 2.1)

Mock-ups include accessibility requirements:
- ✅ Dark mode
- ✅ High contrast
- ✅ Multilingual support (PL/EN)
- ✅ Readable fonts
- ✅ Intuitive navigation

### How to Browse Mock-ups

1. Open `index.html` in your browser
2. Navigate through available views
3. Test different modes (dark, contrast, language)

### ⚠️ What is NOT in This Directory

**Django administrative panel mock-ups are NOT located here.**

Panels for:
- Organizational units
- Content administrators

Are planned as separate Django web interfaces (DTL) and will be documented in:
- **Documentation**: [`docs/MOCKUPY.md`](../MOCKUPY.md)
- **Future mock-ups**: `docs/mock_django/` (PlantUML salt format)

### Technical Architecture

```
┌─────────────────────────────────┐
│  Flutter App (Student)          │
│                                  │
│  - Android                       │
│  - iOS                           │
│  - Mock-ups: docs/mock/ (HTML)   │
└─────────────────────────────────┘
           ↓
    REST API (DRF)
           ↓
┌─────────────────────────────────┐
│     Django Backend + DB         │
└─────────────────────────────────┘
```

---

## 📚 Related Documentation / Powiązana Dokumentacja

- **Full mock-ups documentation / Pełna dokumentacja mock-upów**: [`docs/MOCKUPY.md`](../MOCKUPY.md)
- **Requirements / Wymagania**: [`docs/docs.md`](../docs.md)
- **Functional specification / Specyfikacja funkcjonalna**: [`docs/specs.md`](../specs.md)
- **Database diagrams / Diagramy bazy danych**: [`docs/diagrams/`](../diagrams/)

---

**Created / Utworzono**: 2026-01-13

**Version / Wersja**: 1.0
