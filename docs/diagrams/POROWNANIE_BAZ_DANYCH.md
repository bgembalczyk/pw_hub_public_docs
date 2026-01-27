# Porównanie Schematu Bazy Danych: database.puml vs database_new.puml

## Przegląd

Ten dokument porównuje oryginalny plik `database.puml` z nowym rozszerzonym schematem `database_new.puml`.

## Statystyki

| Metryka | Oryginalny (database.puml) | Nowy (database_new.puml) | Zmiana |
|---------|---------------------------|--------------------------|--------|
| **Całkowita liczba linii** | 123 | 511 | +388 (+315%) |
| **Encje** | 9 | 27 | +18 (+200%) |
| **Relacje** | 11 | 29 | +18 (+164%) |

## Porównanie Encji

### 1. Moduł Users (Użytkownicy)

#### Oryginalne Encje
- `Users.User` (podstawowe pola)
- `Users.Preference` (podstawowe preferencje)

#### Ulepszenia w database_new.puml
- **Users.User**: Dodano `username`, `is_active`, `date_joined`, `last_login`, `preferred_language`
- **Users.Preference**: Dodano ustawienia powiadomień (`receive_event_notifications`, `receive_announcement_notifications`, `receive_usos_reminders`)

---

### 2. Moduł Permissions (Uprawnienia)

#### Status: ✅ ZACHOWANE (Bez zmian)
Wszystkie encje zachowane dokładnie jak w oryginale:
- `Permissions.Permission_Group`
- `Permissions.Permission_Scheme`
- `Permissions.Permission`

---

### 3. Moduł Units (Jednostki Organizacyjne)

#### Oryginalne Encje
- `Units.Unit` (podstawowa jednostka organizacyjna)

#### Ulepszenia w database_new.puml
- **Units.Unit**: Dodano `short_name`, `description`, `created_at`, `updated_at`

---

### 4. Moduł Announcements (Ogłoszenia)

#### Oryginalne Encje
- `Announcements.Announcement` (podstawowe ogłoszenie)

#### Ulepszenia w database_new.puml
- **Announcements.Announcement**: Dodano `excerpt`, `published`, `published_at`, `language`
- **NOWE: Announcements.Category**: System kategoryzacji (Uczelnia, Kwaterunek, Rekrutacja, Samorząd)
- **NOWE: Announcements.Image**: Wsparcie dla obrazów/miniaturek w ogłoszeniach

**Wartość biznesowa**: Umożliwia filtrowanie i lepszą wizualną prezentację aktualności

---

### 5. Moduł Events (Wydarzenia)

#### Oryginalne Encje
- `Events.Event` (podstawowe wydarzenie z tytułem, opisem, datami, lokalizacją, organizatorem)

#### Znaczne Rozszerzenie w database_new.puml

**Ulepszone Events.Event**: Dodano:
- Wsparcie dla języków (`language`)
- Kontrola publikacji (`is_published`)
- Zarządzanie rejestracją (`registration_required`, `registration_deadline`, `capacity`)
- Ścieżka audytu (`created_at`, `updated_at`, `created_by`)

**NOWE Encje (8 dodatkowych encji):**

1. **Events.Category**
   - Cel: Kategoryzacja wydarzeń (Kultura, Sport, Nauka, Integracja, Wyjazdy, Konferencje, Imprezy, Technologia)
   - Pola: name, slug, icon, color
   - Wartość biznesowa: Lepsza możliwość odkrywania i filtrowania wydarzeń

2. **Events.Registration**
   - Cel: Zarządzanie zapisami użytkowników na wydarzenia
   - Pola: user, event, status (confirmed/cancelled/waitlist), data zapisu, dane uczestnika
   - Wartość biznesowa: Implementuje wymaganie 4.3 (Rejestracja i wejściówki)

3. **Events.Ticket**
   - Cel: Cyfrowe wejściówki z kodami QR
   - Pola: referencja do rejestracji, ticket_code, qr_code, issued_at, scanned_at, is_valid
   - Wartość biznesowa: Implementuje system cyfrowych wejściówek ze specyfikacji (sekcja 4.3)

4. **Events.Accessibility**
   - Cel: Informacje o dostępności dla każdego wydarzenia
   - Pola: wheelchair_accessible, elevator_available, quiet_event, low_sensory_stimulation, sign_language_available, live_streaming, accessibility_notes
   - Wartość biznesowa: Implementuje wymaganie 4.4 (Informacje o dostępności wydarzeń)

5. **Events.FAQ**
   - Cel: FAQ specyficzne dla wydarzenia
   - Pola: question, answer, order, helpful_count
   - Wartość biznesowa: Widoczne w mock-upie event-details.html

6. **Events.Attachment**
   - Cel: Materiały do pobrania i linki
   - Pola: title, description, file/url, file_type (pdf/link/image), icon
   - Wartość biznesowa: Agenda, regulaminy, linki Discord (z mock-upów)

7. **Events.Photo**
   - Cel: Galerie zdjęć z wydarzeń
   - Pola: image, alt_text, caption, order
   - Wartość biznesowa: Galerie zdjęć z poprzednich edycji (z mock-upów)

8. **Events.Cost**
   - Cel: Informacje o cenach
   - Pola: participant_type, amount, currency, description
   - Wartość biznesowa: Różne ceny dla studentów i uczestników zewnętrznych (z mock-upów)

---

### 6. Moduł GIS/Maps (Mapy)

#### Oryginalne Encje
- `GIS.Map.Place` (podstawowe miejsce z wielokątami)

#### Ulepszenia w database_new.puml
- **GIS.Map.Place**: Dodano `address`, `latitude`, `longitude`, `building_number`, `room_number`, `floor`, `wheelchair_accessible`, `has_elevator`
- **NOWE: GIS.Map.Route**: Trasy piesze wraz z trasami dostępnymi
  - Pola: start_place, end_place, waypoints, distance, estimated_time, accessible_route
  - Wartość biznesowa: Implementuje wymaganie 4.5 (Mapy kampusu z trasami dostępnymi)

---

### 7. Moduł Guides (Poradniki) - CAŁKOWICIE NOWY

**NOWE Encje (3 encje):**

1. **Guides.Guide**
   - Cel: Tutoriale i poradniki dla studentów
   - Pola: title, content, excerpt, author, category, status publikacji, language
   - Wartość biznesowa: Widoczne w mock-upie guides.html

2. **Guides.Category**
   - Cel: Kategoryzacja poradników
   - Pola: name, slug, icon
   - Wartość biznesowa: Organizacja poradników według tematów

3. **Guides.Contact**
   - Cel: Punkty kontaktowe (Dziekanat, WRS, Rada Mieszkańców)
   - Pola: name, description, contact_type, unit, location, room_number, opening_hours, email, phone, website, icon
   - Wartość biznesowa: Widoczne w mock-upie guides.html - karty kontaktowe

---

### 8. Moduł USOS Integration (Integracja z USOS) - CAŁKOWICIE NOWY

**NOWE Encje (2 encje):**

1. **USOS.Reminder**
   - Cel: Przypomnienia z systemu USOS
   - Pola: user, reminder_type (zapisy_na_zajecia, egzamin, platnosc, termin_administracyjny), title, description, due_date, is_read, is_dismissed
   - Wartość biznesowa: Implementuje wymaganie 4.6 (Integracja z USOS)

2. **USOS.Sync**
   - Cel: Śledzenie statusu synchronizacji z USOS
   - Pola: user, last_sync, sync_status, error_message
   - Wartość biznesowa: Monitorowanie stanu integracji

---

### 9. Moduł Notifications (Powiadomienia) - CAŁKOWICIE NOWY

**NOWA Encja:**

1. **Notifications.Notification**
   - Cel: System powiadomień push
   - Pola: user, notification_type, title, message, related_object (polimorficzny), created_at, read_at, is_read, push_sent, push_sent_at
   - Wartość biznesowa: Implementuje sekcję 3.9 (Powiadomienia) ze specyfikacji

---

## Analiza Pokrycia Wymagań

| Wymaganie (ze specs.md) | Pokrycie Oryginalne | Nowe Pokrycie | Status |
|-------------------------|---------------------|---------------|--------|
| 4.1 System aktualności | Częściowe (podstawowy Announcement) | ✅ Pełne (Category, Image, język) | ✅ Ulepszone |
| 4.2 Kalendarz wydarzeń | Częściowe (podstawowy Event) | ✅ Pełne (Category, filtry) | ✅ Ulepszone |
| 4.3 Rejestracja i wejściówki | ❌ Brak | ✅ Pełne (Registration, Ticket) | ✅ Dodane |
| 4.4 Informacje o dostępności | ❌ Brak | ✅ Pełne (encja Accessibility) | ✅ Dodane |
| 4.5 Mapy kampusu | Częściowe (tylko Place) | ✅ Pełne (Place + Route + dostępność) | ✅ Ulepszone |
| 4.6 Integracja z USOS | ❌ Brak | ✅ Pełne (Reminder, Sync) | ✅ Dodane |
| 3.9 Powiadomienia | ❌ Brak | ✅ Pełne (Notification) | ✅ Dodane |

## Kluczowe Ulepszenia

### 1. Dostępność na Pierwszym Miejscu
- Informacje o dostępności wydarzeń (wózek, cisza, bodźce sensoryczne)
- Dostępne trasy na mapach
- Wsparcie dla zgodności z WCAG 2.1

### 2. Wsparcie Wielojęzyczne
- Pole language w Events, Announcements, Guides
- Wsparcie dla PL/EN zgodnie z wymaganiami

### 3. Doświadczenie Użytkownika
- FAQ do wydarzeń redukują obciążenie wsparciem
- Galerie zdjęć zachęcają do uczestnictwa
- Szczegółowe informacje o kosztach ustawiają oczekiwania

### 4. Gotowość do Integracji
- System przypomnień USOS
- Infrastruktura powiadomień
- Śledzenie statusu synchronizacji

### 5. Bogate Treści
- Wsparcie obrazów dla ogłoszeń
- System załączników dla wydarzeń
- Wsparcie galerii

## Uwagi o Migracji

Podczas implementacji `database_new.puml`:

1. **Kompatybilność Wsteczna**: Wszystkie oryginalne encje są zachowane z ulepszeniami
2. **Nowe Klucze Obce**: Będą potrzebne migracje dla nowych relacji
3. **Migracja Danych**: Istniejące dane kompatybilne; nowe pola mają sensowne wartości domyślne
4. **Wymagane Zmiany**:
   - Model Event: dodać pola rejestracji
   - Model Announcement: dodać relację do kategorii
   - Utworzyć nowe modele: Registration, Ticket, Accessibility, etc.

## Podsumowanie

Nowy schemat (`database_new.puml`) to kompleksowe rozszerzenie, które:
- ✅ Zachowuje wszystkie oryginalne encje
- ✅ Ulepsza istniejące encje o brakujące pola
- ✅ Dodaje 18 nowych encji dla pełnego pokrycia funkcjonalności
- ✅ Adresuje wszystkie wymagania z docs.md i specs.md
- ✅ Odzwierciedla elementy UI z HTML mock-upów
- ✅ Wspiera wymagania dostępności WCAG 2.1
- ✅ Umożliwia działanie wielojęzyczne (PL/EN)

**Rekomendacja**: Użyj `database_new.puml` jako podstawy do implementacji modeli Django.

---

## Lista Zmian - Szczegóły

### Zachowane z Oryginału (bez zmian w logice)
- Permissions.Permission_Group
- Permissions.Permission_Scheme
- Permissions.Permission

### Ulepszone (dodano pola, zachowano całą oryginalną logikę)
- Users.User (+ pola uwierzytelniania i preferencji językowych)
- Users.Preference (+ preferencje powiadomień)
- Units.Unit (+ metadane)
- Announcements.Announcement (+ publikacja i język)
- Events.Event (+ rejestracja, publikacja, język)
- GIS.Map.Place (+ szczegóły lokalizacji i dostępność)

### Całkowicie Nowe Moduły
- **Announcements**: Category, Image (2 encje)
- **Events**: Category, Registration, Ticket, Accessibility, FAQ, Attachment, Photo, Cost (8 encji)
- **GIS**: Route (1 encja)
- **Guides**: Guide, Category, Contact (3 encje)
- **USOS**: Reminder, Sync (2 encje)
- **Notifications**: Notification (1 encja)

**Razem nowych encji**: 17
**Razem ulepszonych encji**: 6
**Razem zachowanych bez zmian**: 3

## Zgodność z Mock-upami HTML

| Mock-up HTML | Encje które to wspierają |
|--------------|--------------------------|
| home.html | Announcement, Event, Category, USOS.Reminder |
| event-details.html | Event, Accessibility, FAQ, Attachment, Photo, Cost |
| event-ticket.html | Registration, Ticket |
| events.html | Event, Category |
| news.html | Announcement, Category, Image |
| guides.html | Guide, Contact |
| map-card.html | Place, Route |

✅ **Wszystkie elementy z mock-upów są wspierane przez nowy schemat**
