# Database Schema Comparison: database.puml vs database_new.puml

## Overview

This document compares the original `database.puml` with the new extended `database_new.puml` schema.

## Statistics

| Metric | Original (database.puml) | New (database_new.puml) | Change |
|--------|-------------------------|------------------------|--------|
| **Total Lines** | 123 | 511 | +388 (+315%) |
| **Entities** | 9 | 27 | +18 (+200%) |
| **Relationships** | 11 | 29 | +18 (+164%) |

## Entities Comparison

### 1. Users Module

#### Original Entities
- `Users.User` (basic fields)
- `Users.Preference` (basic preferences)

#### Enhancements in database_new.puml
- **Users.User**: Added `username`, `is_active`, `date_joined`, `last_login`, `preferred_language`
- **Users.Preference**: Added notification settings (`receive_event_notifications`, `receive_announcement_notifications`, `receive_usos_reminders`)

---

### 2. Permissions Module

#### Status: ✅ PRESERVED (No changes)
All entities preserved exactly as in original:
- `Permissions.Permission_Group`
- `Permissions.Permission_Scheme`
- `Permissions.Permission`

---

### 3. Units Module

#### Original Entities
- `Units.Unit` (basic organizational unit)

#### Enhancements in database_new.puml
- **Units.Unit**: Added `short_name`, `description`, `created_at`, `updated_at`

---

### 4. Announcements Module

#### Original Entities
- `Announcements.Announcement` (basic announcement)

#### Enhancements in database_new.puml
- **Announcements.Announcement**: Added `excerpt`, `published`, `published_at`, `language`
- **NEW: Announcements.Category**: Categorization system (Uczelnia, Kwaterunek, Rekrutacja, Samorząd)
- **NEW: Announcements.Image**: Image/thumbnail support for announcements

**Business Value**: Enables filtering and better visual presentation of news

---

### 5. Events Module

#### Original Entities
- `Events.Event` (basic event with title, description, dates, location, organizer)

#### Major Expansion in database_new.puml

**Enhanced Events.Event**: Added:
- Language support (`language`)
- Publication control (`is_published`)
- Registration management (`registration_required`, `registration_deadline`, `capacity`)
- Audit trail (`created_at`, `updated_at`, `created_by`)

**NEW Entities (8 additional entities):**

1. **Events.Category**
   - Purpose: Categorize events (Kultura, Sport, Nauka, Integracja, Wyjazdy, Konferencje, Imprezy, Technologia)
   - Fields: name, slug, icon, color
   - Business Value: Better event discovery and filtering

2. **Events.Registration**
   - Purpose: Manage user registrations for events
   - Fields: user, event, status (confirmed/cancelled/waitlist), registration date, participant details
   - Business Value: Implements requirement 4.3 (Rejestracja i wejściówki)

3. **Events.Ticket**
   - Purpose: Digital tickets with QR codes
   - Fields: registration reference, ticket_code, qr_code, issued_at, scanned_at, is_valid
   - Business Value: Implements digital ticket system from specs (section 4.3)

4. **Events.Accessibility**
   - Purpose: Accessibility information per event
   - Fields: wheelchair_accessible, elevator_available, quiet_event, low_sensory_stimulation, sign_language_available, live_streaming, accessibility_notes
   - Business Value: Implements requirement 4.4 (Informacje o dostępności wydarzeń)

5. **Events.FAQ**
   - Purpose: Event-specific FAQs
   - Fields: question, answer, order, helpful_count
   - Business Value: Seen in event-details.html mock-up

6. **Events.Attachment**
   - Purpose: Downloadable materials and links
   - Fields: title, description, file/url, file_type (pdf/link/image), icon
   - Business Value: Agenda, regulations, Discord links (from mock-ups)

7. **Events.Photo**
   - Purpose: Event photo galleries
   - Fields: image, alt_text, caption, order
   - Business Value: Photo galleries from previous editions (from mock-ups)

8. **Events.Cost**
   - Purpose: Pricing information
   - Fields: participant_type, amount, currency, description
   - Business Value: Different pricing for students vs external participants (from mock-ups)

---

### 6. GIS/Maps Module

#### Original Entities
- `GIS.Map.Place` (basic place with polygons)

#### Enhancements in database_new.puml
- **GIS.Map.Place**: Added `address`, `latitude`, `longitude`, `building_number`, `room_number`, `floor`, `wheelchair_accessible`, `has_elevator`
- **NEW: GIS.Map.Route**: Pedestrian routes including accessible routes
  - Fields: start_place, end_place, waypoints, distance, estimated_time, accessible_route
  - Business Value: Implements requirement 4.5 (Mapy kampusu with accessible routes)

---

### 7. Guides Module (COMPLETELY NEW)

**NEW Entities (3 entities):**

1. **Guides.Guide**
   - Purpose: Tutorials and guides for students
   - Fields: title, content, excerpt, author, category, published status, language
   - Business Value: Seen in guides.html mock-up

2. **Guides.Category**
   - Purpose: Guide categorization
   - Fields: name, slug, icon
   - Business Value: Organize guides by topic

3. **Guides.Contact**
   - Purpose: Contact points (Dziekanat, WRS, Rada Mieszkańców)
   - Fields: name, description, contact_type, unit, location, room_number, opening_hours, email, phone, website, icon
   - Business Value: Seen in guides.html mock-up - contact cards

---

### 8. USOS Integration Module (COMPLETELY NEW)

**NEW Entities (2 entities):**

1. **USOS.Reminder**
   - Purpose: Reminders from USOS system
   - Fields: user, reminder_type (zapisy_na_zajecia, egzamin, platnosc, termin_administracyjny), title, description, due_date, is_read, is_dismissed
   - Business Value: Implements requirement 4.6 (Integracja z USOS)

2. **USOS.Sync**
   - Purpose: Track USOS synchronization status
   - Fields: user, last_sync, sync_status, error_message
   - Business Value: Monitor integration health

---

### 9. Notifications Module (COMPLETELY NEW)

**NEW Entity:**

1. **Notifications.Notification**
   - Purpose: Push notifications system
   - Fields: user, notification_type, title, message, related_object (polymorphic), created_at, read_at, is_read, push_sent, push_sent_at
   - Business Value: Implements section 3.9 (Powiadomienia) from specs

---

## Requirements Coverage Analysis

| Requirement (from specs.md) | Original Coverage | New Coverage | Status |
|------------------------------|-------------------|--------------|--------|
| 4.1 System aktualności | Partial (basic Announcement) | ✅ Full (Category, Image, language) | ✅ Enhanced |
| 4.2 Kalendarz wydarzeń | Partial (basic Event) | ✅ Full (Category, filters) | ✅ Enhanced |
| 4.3 Rejestracja i wejściówki | ❌ Missing | ✅ Full (Registration, Ticket) | ✅ Added |
| 4.4 Informacje o dostępności | ❌ Missing | ✅ Full (Accessibility entity) | ✅ Added |
| 4.5 Mapy kampusu | Partial (Place only) | ✅ Full (Place + Route + accessibility) | ✅ Enhanced |
| 4.6 Integracja z USOS | ❌ Missing | ✅ Full (Reminder, Sync) | ✅ Added |
| 3.9 Powiadomienia | ❌ Missing | ✅ Full (Notification) | ✅ Added |

## Key Improvements

### 1. Accessibility First
- Event accessibility information (wheelchair, quiet, sensory)
- Accessible routes in maps
- WCAG 2.1 compliance support

### 2. Multi-language Support
- Language field in Events, Announcements, Guides
- Support for PL/EN as per requirements

### 3. User Experience
- Event FAQs reduce support burden
- Photo galleries encourage participation
- Detailed cost information sets expectations

### 4. Integration Ready
- USOS reminder system
- Notification infrastructure
- Sync status tracking

### 5. Rich Content
- Image support for announcements
- Attachment system for events
- Gallery support

## Migration Notes

When implementing `database_new.puml`:

1. **Backward Compatibility**: All original entities are preserved with enhancements
2. **New Foreign Keys**: Will need migrations for new relationships
3. **Data Migration**: Existing data compatible; new fields have sensible defaults
4. **Required Changes**:
   - Event model: add registration fields
   - Announcement model: add category relationship
   - Create new models: Registration, Ticket, Accessibility, etc.

## Conclusion

The new schema (`database_new.puml`) is a comprehensive expansion that:
- ✅ Preserves all original entities
- ✅ Enhances existing entities with missing fields
- ✅ Adds 18 new entities for complete feature coverage
- ✅ Addresses all requirements from docs.md and specs.md
- ✅ Reflects UI elements from HTML mock-ups
- ✅ Supports WCAG 2.1 accessibility requirements
- ✅ Enables multi-language operation (PL/EN)

**Recommendation**: Use `database_new.puml` as the basis for Django model implementation.
