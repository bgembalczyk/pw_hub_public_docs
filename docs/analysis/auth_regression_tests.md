# Kontrakt testów regresyjnych: autoryzacja i role użytkowników

> Cel: jednoznaczny, powtarzalny kontrakt testowy dla dostępu do paneli, endpointów API i zasobów wrażliwych, bez zmian w logice autoryzacji.

## 1) Role użytkowników

1. **Anonimowy (niezalogowany)** – brak uwierzytelnienia. (Ogólna definicja roli wejściowej dla testów).【F:docs/specs.md†L79-L120】
2. **Student (zalogowany użytkownik aplikacji mobilnej)** – standardowy użytkownik bez uprawnień panelowych. (Źródło roli: specyfikacja aplikacji mobilnej).【F:docs/specs.md†L79-L99】
3. **Organizator / pracownik jednostki (Unit Panel Member)** – użytkownik z dostępem do panelu jednostki poprzez:
   - bycie `unit_head` jednostki lub
   - członkostwo w grupie uprawnień z `unit_panel.access_panel`.【F:pw_hub/unit_panel/README.md†L60-L74】【F:pw_hub/unit_panel/permissions.py†L8-L46】
4. **Administrator merytoryczny (Content Admin)** – użytkownik w grupie `Content Admin` lub staff (`is_staff=True`).【F:pw_hub/content_admin/README.md†L56-L78】【F:pw_hub/content_admin/permissions.py†L12-L36】
5. **Moderator treści (Content Moderator)** – użytkownik w grupie `Content Moderator` z uprawnieniem do moderacji, ale bez dostępu do panelu content admin (brak `content_admin.access_panel`).【F:pw_hub/content_admin/permissions.py†L39-L62】
6. **Staff/Superuser (Django Admin)** – użytkownik `is_staff` (i ewentualnie `is_superuser`) z dostępem do panelu Django Admin; równocześnie spełnia warunek Content Admin. (Admin URL z konfiguracji).【F:config/settings/base.py†L261-L271】【F:config/urls.py†L18-L40】【F:pw_hub/content_admin/permissions.py†L26-L36】
7. **Organizator wydarzenia (Event Organizer)** – użytkownik będący autorem wydarzenia (`created_by`) lub staff; uprawniony do weryfikacji biletów w API. (Rola kontekstowa w testach API).【F:pw_hub/events/api/permissions.py†L23-L40】【F:pw_hub/events/services/tickets.py†L37-L73】

## 2) Obszary chronione (panele, API, zasoby wrażliwe)

### 2.1 Panele web (Django, DTL)
- **Django Admin**: `/admin/` (konfigurowalne przez `ADMIN_URL`).【F:config/settings/base.py†L261-L271】【F:config/urls.py†L18-L40】
- **Unit Panel**: `/panel-jednostki/` + wszystkie podstrony (dashboard, wydarzenia, kalendarz, aktualności, bilety, statystyki, użytkownicy, log).【F:pw_hub/unit_panel/urls.py†L8-L56】【F:pw_hub/unit_panel/README.md†L28-L49】
- **Content Admin Panel**: `/admin-content/` + podstrony (dashboard, treści, moderacja, jednostki, permissions, konfiguracja).【F:pw_hub/content_admin/urls.py†L9-L46】【F:pw_hub/content_admin/README.md†L18-L56】

**Zachowanie na brak dostępu (panele):**
- **Anonimowy** → redirect do logowania (302).【F:pw_hub/content_admin/tests/test_views.py†L70-L88】【F:pw_hub/unit_panel/tests/test_views.py†L58-L73】
- **Zalogowany bez uprawnień** → 403 Forbidden.【F:pw_hub/content_admin/tests/test_views.py†L74-L88】【F:pw_hub/unit_panel/tests/test_views.py†L69-L82】

### 2.2 API (DRF)
Zarejestrowane ViewSety pod `/api/`:
- **Publiczne (AllowAny)**:
  - `/api/events/` (list, retrieve) + `/api/events/calendar/`.
  - `/api/event-categories/`.
  - `/api/guides/`, `/api/guide-categories/`, `/api/contacts/`.
  (Dopuszczają anonima).【F:config/api_router.py†L1-L26】【F:pw_hub/events/api/views.py†L70-L95】【F:pw_hub/guides/api/views.py†L45-L188】
- **Wymagające uwierzytelnienia (IsAuthenticated)**:
  - `/api/announcements/` + `/read`, `/unread`, `/mark_read`.
  - `/api/notifications/` + `/read`.
  - `/api/users/` + `/me`, `/preferences`.
  - `/api/registrations/`.
  - `/api/tickets/` + `/download`.
  (Domyślny poziom uprawnień DRF = IsAuthenticated).【F:config/settings/base.py†L327-L339】【F:pw_hub/announcements/api/views.py†L12-L33】【F:pw_hub/notifications/api/views.py†L18-L39】【F:pw_hub/users/api/views.py†L15-L24】【F:pw_hub/events/api/views.py†L241-L287】
- **Akcje wrażliwe w API**:
  - `/api/events/{id}/register/` i `/api/events/{id}/unregister/` → wymagają uwierzytelnienia.
  - `/api/tickets/verify/` → tylko organizator wydarzenia lub staff. (IsEventOrganizer + logika `verify_ticket`).【F:pw_hub/events/api/views.py†L87-L125】【F:pw_hub/events/api/views.py†L293-L334】【F:pw_hub/events/services/tickets.py†L37-L73】
- **API dokumentacja**:
  - `/api/schema/`, `/api/docs/` → tylko admin (IsAdminUser).【F:config/settings/base.py†L344-L351】【F:config/urls.py†L55-L67】

### 2.3 Zasoby wrażliwe (akcje/moderacja/role)
- **Moderacja treści** w Content Admin (`/admin-content/moderation/`, publikacja).【F:pw_hub/content_admin/urls.py†L25-L37】
- **Zarządzanie uprawnieniami** w Content Admin (`/admin-content/permissions/`, edycja grup).【F:pw_hub/content_admin/urls.py†L31-L39】
- **Zarządzanie użytkownikami jednostki** w Unit Panel (`/panel-jednostki/uzytkownicy/`, assign/remove role).【F:pw_hub/unit_panel/urls.py†L51-L55】
- **Weryfikacja biletów** (`/api/tickets/verify/`) – akcja o wysokim ryzyku eskalacji. 【F:pw_hub/events/api/views.py†L293-L334】【F:pw_hub/events/services/tickets.py†L37-L73】

---

## 3) Macierz ról × dostępów (ALLOW / DENY)

**Legenda:**
- **ALLOW** – dostęp dozwolony.
- **DENY (401)** – brak uwierzytelnienia (API).
- **DENY (403)** – brak uprawnień (API/panel po zalogowaniu).
- **REDIRECT (302)** – przekierowanie do logowania (panele web).

| Rola \ Obszar | Django Admin `/admin/` | Content Admin `/admin-content/*` | Unit Panel `/panel-jednostki/*` | API Publiczne (guides, events list/detail, event-categories, contacts) | API Authed (announcements, notifications, users, registrations, tickets list/detail/download) | API Event register/unregister | API Ticket verify | API Docs/Schema |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| **Anonimowy** | REDIRECT (302) | REDIRECT (302) | REDIRECT (302) | ALLOW (200) | DENY (401) | DENY (401) | DENY (401) | DENY (401/403)* |
| **Student (zalogowany)** | DENY (403) | DENY (403) | DENY (403) | ALLOW (200) | ALLOW (200) | ALLOW (200) | DENY (403) | DENY (403) |
| **Unit Panel Member (organizator/jednostka)** | DENY (403) | DENY (403) | ALLOW (200) | ALLOW (200) | ALLOW (200) | ALLOW (200) | DENY (403)** | DENY (403) |
| **Content Admin** | DENY (403)*** | ALLOW (200) | DENY (403) | ALLOW (200) | ALLOW (200) | ALLOW (200) | DENY (403)** | DENY (403) |
| **Content Moderator** | DENY (403) | DENY (403) | DENY (403) | ALLOW (200) | ALLOW (200) | ALLOW (200) | DENY (403)** | DENY (403) |
| **Staff/Superuser** | ALLOW (200) | ALLOW (200) | DENY (403)**** | ALLOW (200) | ALLOW (200) | ALLOW (200) | ALLOW (200) | ALLOW (200) |
| **Event Organizer (created_by)** | DENY (403) | DENY (403) | DENY (403) | ALLOW (200) | ALLOW (200) | ALLOW (200) | ALLOW (200) | DENY (403) |

\* API docs/schema są zabezpieczone IsAdminUser; anon powinien dostawać 403 (lub 401 w zależności od middleware). Kontrakt: brak dostępu. 【F:config/settings/base.py†L344-L351】

\** Ticket verify wymaga roli organizatora wydarzenia lub staff. Dostęp innych ról → 403. 【F:pw_hub/events/api/views.py†L293-L334】【F:pw_hub/events/services/tickets.py†L60-L73】

\*** Content Admin nie ma automatycznego dostępu do Django Admin – brak `is_staff`. Jeśli jest staff, to rola przechodzi do wiersza Staff/Superuser. 【F:pw_hub/content_admin/permissions.py†L26-L36】

\**** Unit Panel Member nie jest automatycznie staff; staff nie ma automatycznego uprawnienia `unit_panel.access_panel` (brak reguły).【F:pw_hub/unit_panel/permissions.py†L8-L46】

---

## 4) Zestaw testów pozytywnych (ALLOW)

Poniższe testy są **regresyjne** i mają być wykonywane w obu poziomach (integracyjne i e2e – zgodnie z mapowaniem w sekcji 6).

### 4.1 Panele web (ALLOW)
1. **Content Admin panel (dashboard)**
   - **Given**: użytkownik Content Admin.
   - **When**: GET `/admin-content/`.
   - **Then**: 200 OK, render dashboard. 【F:pw_hub/content_admin/urls.py†L21-L25】
2. **Content Admin – moderacja**
   - **Given**: użytkownik Content Admin.
   - **When**: GET `/admin-content/moderation/`.
   - **Then**: 200 OK. 【F:pw_hub/content_admin/urls.py†L25-L30】
3. **Unit Panel – dashboard**
   - **Given**: Unit Panel Member (`unit_panel.access_panel`).
   - **When**: GET `/panel-jednostki/`.
   - **Then**: 200 OK. 【F:pw_hub/unit_panel/urls.py†L10-L14】
4. **Unit Panel – zarządzanie użytkownikami**
   - **Given**: Unit Panel Member.
   - **When**: GET `/panel-jednostki/uzytkownicy/`.
   - **Then**: 200 OK. 【F:pw_hub/unit_panel/urls.py†L51-L55】
5. **Django Admin**
   - **Given**: użytkownik `is_staff`.
   - **When**: GET `/admin/`.
   - **Then**: 200 OK. 【F:config/settings/base.py†L261-L271】【F:config/urls.py†L18-L40】

### 4.2 API (ALLOW)
6. **Public events list**
   - **Given**: anonimowy.
   - **When**: GET `/api/events/`.
   - **Then**: 200 OK. 【F:config/api_router.py†L1-L26】【F:pw_hub/events/api/views.py†L87-L95】
7. **Public guides list**
   - **Given**: anonimowy.
   - **When**: GET `/api/guides/`.
   - **Then**: 200 OK. 【F:config/api_router.py†L1-L26】【F:pw_hub/guides/api/views.py†L45-L95】
8. **Announcements list**
   - **Given**: zalogowany student.
   - **When**: GET `/api/announcements/`.
   - **Then**: 200 OK. 【F:pw_hub/announcements/api/views.py†L12-L33】
9. **Notifications list**
   - **Given**: zalogowany student.
   - **When**: GET `/api/notifications/`.
   - **Then**: 200 OK. 【F:pw_hub/notifications/api/views.py†L18-L39】
10. **User profile (me)**
    - **Given**: zalogowany student.
    - **When**: GET `/api/users/me/`.
    - **Then**: 200 OK i dane użytkownika. 【F:pw_hub/users/api/views.py†L15-L38】
11. **Event register/unregister**
    - **Given**: zalogowany student.
    - **When**: POST `/api/events/{id}/register/`.
    - **Then**: 200 OK (lub 400/409 w zależności od stanu, ale brak 401). 【F:pw_hub/events/api/views.py†L87-L160】
12. **Ticket download**
    - **Given**: zalogowany student, właściciel biletu.
    - **When**: GET `/api/tickets/{id}/download/`.
    - **Then**: 200 OK. 【F:pw_hub/events/api/views.py†L251-L287】
13. **Ticket verify (organizer/staff)**
    - **Given**: organizator wydarzenia lub staff.
    - **When**: POST `/api/tickets/verify/` z poprawnym `ticket_code`.
    - **Then**: 200 OK, `valid=true`. 【F:pw_hub/events/api/views.py†L293-L334】【F:pw_hub/events/services/tickets.py†L37-L90】
14. **API docs/schema (admin)**
    - **Given**: staff/admin.
    - **When**: GET `/api/docs/` oraz `/api/schema/`.
    - **Then**: 200 OK. 【F:config/settings/base.py†L344-L351】【F:config/urls.py†L55-L67】

---

## 5) Zestaw testów negatywnych (DENY)

### 5.1 Brak uwierzytelnienia (anonim)
1. **Anonim → Content Admin**
   - **Given**: anonimowy.
   - **When**: GET `/admin-content/`.
   - **Then**: redirect 302 do logowania. 【F:pw_hub/content_admin/tests/test_views.py†L70-L88】
2. **Anonim → Unit Panel**
   - **Given**: anonimowy.
   - **When**: GET `/panel-jednostki/`.
   - **Then**: redirect 302 do logowania. 【F:pw_hub/unit_panel/tests/test_views.py†L58-L73】
3. **Anonim → Announcements API**
   - **Given**: anonimowy.
   - **When**: GET `/api/announcements/`.
   - **Then**: 401 Unauthorized. 【F:pw_hub/announcements/api/views.py†L12-L33】【F:config/settings/base.py†L327-L339】
4. **Anonim → Event register**
   - **Given**: anonimowy.
   - **When**: POST `/api/events/{id}/register/`.
   - **Then**: 401 Unauthorized. 【F:pw_hub/events/api/views.py†L87-L125】
5. **Anonim → Ticket verify**
   - **Given**: anonimowy.
   - **When**: POST `/api/tickets/verify/`.
   - **Then**: 401 Unauthorized. 【F:pw_hub/events/api/views.py†L293-L334】

### 5.2 Brak uprawnień (zalogowany, ale bez roli)
6. **Student → Content Admin**
   - **Given**: zalogowany student.
   - **When**: GET `/admin-content/`.
   - **Then**: 403 Forbidden. 【F:pw_hub/content_admin/tests/test_views.py†L74-L88】
7. **Student → Unit Panel**
   - **Given**: zalogowany student.
   - **When**: GET `/panel-jednostki/`.
   - **Then**: 403 Forbidden. 【F:pw_hub/unit_panel/tests/test_views.py†L69-L82】
8. **Unit Panel Member → Content Admin**
   - **Given**: Unit Panel Member.
   - **When**: GET `/admin-content/`.
   - **Then**: 403 Forbidden. 【F:pw_hub/content_admin/permissions.py†L12-L36】
9. **Content Admin → Unit Panel**
   - **Given**: Content Admin bez `unit_panel.access_panel`.
   - **When**: GET `/panel-jednostki/`.
   - **Then**: 403 Forbidden. 【F:pw_hub/unit_panel/permissions.py†L8-L46】
10. **Content Moderator → Content Admin panel**
    - **Given**: Content Moderator (bez `content_admin.access_panel`).
    - **When**: GET `/admin-content/`.
    - **Then**: 403 Forbidden. 【F:pw_hub/content_admin/permissions.py†L39-L62】
11. **Student → Ticket verify**
    - **Given**: zalogowany student.
    - **When**: POST `/api/tickets/verify/`.
    - **Then**: 403 Forbidden. 【F:pw_hub/events/api/views.py†L293-L334】【F:pw_hub/events/services/tickets.py†L60-L73】
12. **Unit Panel Member → Ticket verify (nie organizator)**
    - **Given**: Unit Panel Member, który nie jest organizatorem danego wydarzenia.
    - **When**: POST `/api/tickets/verify/`.
    - **Then**: 403 Forbidden. 【F:pw_hub/events/services/tickets.py†L60-L73】
13. **Student → API docs/schema**
    - **Given**: zalogowany student.
    - **When**: GET `/api/docs/` lub `/api/schema/`.
    - **Then**: 403 Forbidden. 【F:config/settings/base.py†L344-L351】

### 5.3 Eskalacja uprawnień i dostęp pośredni
14. **Direct URL access (unit panel)**
    - **Given**: zalogowany student.
    - **When**: bezpośredni GET `/panel-jednostki/uzytkownicy/`.
    - **Then**: 403 Forbidden. 【F:pw_hub/unit_panel/urls.py†L51-L55】【F:pw_hub/unit_panel/permissions.py†L8-L46】
15. **Direct URL access (content admin moderation)**
    - **Given**: zalogowany student.
    - **When**: GET `/admin-content/moderation/`.
    - **Then**: 403 Forbidden. 【F:pw_hub/content_admin/urls.py†L25-L30】【F:pw_hub/content_admin/permissions.py†L12-L36】
16. **Dostęp do cudzych zasobów (tickets)**
    - **Given**: zalogowany student A.
    - **When**: GET `/api/tickets/{id}/` należącego do studenta B.
    - **Then**: 404 Not Found (brak wycieku, queryset filtrowany po użytkowniku) lub 403 – brak dostępu. 【F:pw_hub/events/api/views.py†L251-L287】
17. **Dostęp do cudzych zasobów (notifications)**
    - **Given**: zalogowany student A.
    - **When**: GET `/api/notifications/{id}/` należącej do studenta B.
    - **Then**: 404 Not Found (brak wycieku). 【F:pw_hub/notifications/api/views.py†L31-L48】

---

## 6) Mapowanie scenariuszy → poziomy testów

### Integracyjne (Django + DRF)
- Panele web: scenariusze 1–5 (pozytywne) i 1–15 (negatywne) z sekcji 4–5.
  - Narzędzia: Django `client` / `RequestFactory`.
  - Walidacja: kody odpowiedzi (200/302/403), brak renderowania zasobów bez dostępu.
- API: scenariusze 6–14 (pozytywne) i 3–13 (negatywne).
  - Narzędzia: DRF `APIClient`.
  - Walidacja: 200, 401, 403, 404 (obiektowe) + brak danych w payload.

### E2E (jeśli przewidziane przez projekt)
- Cross-role flows:
  - logowanie jako student/organizator/content admin/staff, próby wejścia do paneli.
  - weryfikacja zachowań redirect vs 403.
  - próby akcji wrażliwych (`/api/tickets/verify/`, moderacja, zarządzanie rolami) z niewłaściwych kont.

---

## 7) Najbardziej krytyczne obszary i ryzyka regresji

### Krytyczne obszary
1. **Panele administracyjne (Content Admin, Unit Panel, Django Admin)** – wysoki wpływ na integralność danych i uprawnienia. 【F:pw_hub/content_admin/urls.py†L9-L46】【F:pw_hub/unit_panel/urls.py†L8-L56】【F:config/urls.py†L18-L40】
2. **Weryfikacja biletów** – bezpośredni wpływ na dostęp do wydarzeń. 【F:pw_hub/events/services/tickets.py†L37-L90】
3. **Zarządzanie rolami i uprawnieniami** – ryzyko eskalacji. 【F:pw_hub/content_admin/urls.py†L31-L39】【F:pw_hub/unit_panel/urls.py†L51-L55】

### Jakie regresje mają wykrywać testy
- **Nieautoryzowany dostęp do paneli** po zmianach routing/permissions (testy 1–2, 6–10, 14–15).【F:pw_hub/content_admin/tests/test_views.py†L70-L88】【F:pw_hub/unit_panel/tests/test_views.py†L58-L82】
- **Ciche otwarcie endpointów API** (testy 3–5, 11–13).【F:config/settings/base.py†L327-L339】【F:pw_hub/announcements/api/views.py†L12-L33】
- **Eskalacja uprawnień na zasobach wrażliwych** (testy 11–17).【F:pw_hub/events/services/tickets.py†L60-L73】【F:pw_hub/events/api/views.py†L251-L334】

---

## 8) Notatka o spójności kontraktu

- **Creed of Truth**: każdy test ma binarny wynik (ALLOW/DENY), z jednoznacznym kodem odpowiedzi i spodziewanym zachowaniem. Testy negatywne nie akceptują „cichych” sukcesów (np. 200 bez danych).【F:config/settings/base.py†L327-L339】
- **Security Paladin**: pokrycie wektorów eskalacji uprawnień (direct URL, obiekty cudze, ticket verify).【F:pw_hub/events/services/tickets.py†L60-L73】
- **QA Witcher**: format Given/When/Then oraz separacja testów pozytywnych/negatywnych gwarantuje powtarzalność. 【F:pw_hub/content_admin/tests/test_views.py†L70-L88】
