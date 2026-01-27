# Content Admin Panel

Panel Administratora Merytorycznego - dedykowany panel administracyjny dla zarządzania treścią w systemie PW_hub.

## Opis

Content Admin Panel to oddzielny od Django Admin interfejs webowy, zaprojektowany specjalnie dla administratorów merytorycznych (nietechnicznych) do zarządzania wszystkimi treściami i jednostkami w systemie.

## Funkcjonalności

### 1. Dashboard
- Statystyki systemowe (aktywni użytkownicy, opublikowane treści)
- Ostatnie aktywności w systemie
- Top 5 najbardziej aktywnych jednostek
- Szybkie akcje (nowa aktualność, nowe wydarzenie, moderacja)

**URL**: `/admin-content/`

### 2. Zarządzanie Treścią
- Lista wszystkich treści (aktualności, wydarzenia, poradniki)
- Filtrowanie po typie treści
- Filtrowanie po statusie (opublikowane/oczekujące)
- Wyszukiwanie po tytule i treści
- Szybki dostęp do edycji i podglądu

**URL**: `/admin-content/content/`

### 3. Kolejka Moderacji
- Lista wszystkich treści oczekujących na publikację
- Priorytety (wysoki priorytet dla treści starszych niż 2 dni)
- Szybkie zatwierdzanie treści
- Podgląd przed publikacją

**URL**: `/admin-content/moderation/`

### 4. Zarządzanie Jednostkami
- Lista wszystkich jednostek organizacyjnych
- Statystyki publikacji dla każdej jednostki
- Liczba aktualności i wydarzeń

**URL**: `/admin-content/units/`

### 5. Zarządzanie Uprawnieniami
- Przegląd grup uprawnień (Permission Groups)
- Dziennik audytowy (Audit Log)

**URL**: `/admin-content/permissions/`

### 6. Konfiguracja Systemu
- Ustawienia globalne, integracje, bezpieczeństwo, moderacja, interfejs, email
- Historia zmian konfiguracji

**URL**: `/admin-content/configuration/`

## Uprawnienia

### Role
1. **Content Admin** - pełny dostęp do panelu
2. **Staff Users** - automatycznie mają dostęp jako content admins
3. **Content Moderator** - dostęp tylko do moderacji (do rozszerzenia w przyszłości)

### Konfiguracja Uprawnień

Aby nadać użytkownikowi dostęp do panelu:

```python
from django.contrib.auth.models import Group
from pw_hub.users.models import User

# Utwórz grupę Content Admin (jednorazowo)
content_admin_group, created = Group.objects.get_or_create(name="Content Admin")

# Dodaj użytkownika do grupy
user = User.objects.get(username="jan.kowalski")
user.groups.add(content_admin_group)
```

Lub przez Django Admin:
1. Przejdź do Django Admin (/admin/)
2. Users → wybierz użytkownika
3. W sekcji "Groups" dodaj "Content Admin"
4. Zapisz

## Technologia

- **Framework**: Django (bez warstwy API)
- **Template Engine**: Django Template Language (DTL)
- **Permissions**: django-rules
- **Frontend**: Bootstrap 5
- **Dostępność**: WCAG 2.1
- **Języki**: Polski, Angielski

## Architektura

```
content_admin/
├── models.py           # Modele (SystemConfiguration, AdminAuditLog)
├── permissions.py       # Predykaty uprawnień django-rules
├── views.py            # Widoki CBV (Class-Based Views)
├── urls.py             # Konfiguracja URL
├── apps.py             # Konfiguracja aplikacji
└── tests/              # Testy
    ├── test_permissions.py
    └── test_views.py

templates/content_admin/
├── base.html           # Szablon bazowy z nawigacją
├── dashboard.html      # Dashboard
├── content_list.html   # Lista treści
├── moderation_queue.html  # Kolejka moderacji
├── unit_list.html      # Lista jednostek
├── permissions.html    # Zarządzanie uprawnieniami
└── configuration.html  # Konfiguracja systemu
```

## Testowanie

Uruchom testy:

```bash
# Wszystkie testy content_admin
just pytest pw_hub/content_admin/

# Testy uprawnień
just pytest pw_hub/content_admin/tests/test_permissions.py

# Testy widoków
just pytest pw_hub/content_admin/tests/test_views.py
```

## Mockupy

Mockupy interfejsu znajdują się w `docs/mock_django/admin_panel/`:
- `admin_dashboard.puml` - Dashboard administratora
- `content_moderation.puml` - Moderacja treści
- `unit_management.puml` - Zarządzanie jednostkami
- `global_statistics.puml` - Globalne statystyki
- `system_configuration.puml` - Konfiguracja systemu
- `permissions_management.puml` - Zarządzanie uprawnieniami

## Dostępność (WCAG 2.1)

Panel został zaprojektowany z myślą o dostępności:

- ✅ Nawigacja klawiaturą (Tab, Enter, Escape)
- ✅ Etykiety ARIA dla czytników ekranu
- ✅ Semantyczny HTML (nav, main, header)
- ✅ Kontrast kolorów zgodny z WCAG AA
- ✅ Responsywny design (mobile-first)

## Rozwój

### Zrealizowane funkcjonalności

- [x] Zarządzanie uprawnieniami użytkowników (widok Permission Groups)
- [x] Konfiguracja systemowa (Model Singleton)
- [x] Akcje masowe (zatwierdź/odrzuć zaznaczone w moderacji)
- [x] Eksport raportów (CSV z kolejki moderacji)
- [x] Historia zmian (Audit Log w permissions i configuration)
- [x] Powiadomienia dla administratorów (Dashboard)

### Znane ograniczenia

## Strategia Danych (No Migrations Rule)

W celu zachowania elastyczności i unikania częstych migracji bazy danych dla modułów administracyjnych, zastosowano następujące podejście:

1. **SystemConfiguration**: Model typu Singleton przechowujący konfigurację w polach JSON (`general`, `security`, etc.). Pozwala to na dodawanie nowych opcji konfiguracyjnych bez zmiany schematu bazy danych.
2. **AdminAuditLog**: Model przechowujący historię zmian, gdzie szczegóły operacji są zapisywane w polu JSON.

Zmiany w tych modelach są obsługiwane bezpośrednio, a struktura JSON pozwala na dynamiczne dostosowywanie formularzy konfiguracyjnych.

## Wsparcie

W razie pytań lub problemów:
1. Sprawdź dokumentację w `docs/`
2. Zobacz testy w `pw_hub/content_admin/tests/`
3. Zgłoś issue na GitHubie

## Licencja

MIT - zgodnie z licencją projektu PW_hub
