# Reference test environment & minimal fixtures (QA contract)

Ten dokument definiuje **referencyjne środowisko testowe** oraz **minimalny, deterministyczny zestaw fixtures** dla projektu PW_hub. Celem jest powtarzalność: *ten sam commit + to samo środowisko = te same wyniki*.

## 1) Reference test environment

### 1.1 System i tryb uruchomienia
- **Preferowany tryb**: Docker Compose (`docker-compose.local.yml`).
- **Środowiska**:
  - **Lokalnie**: Docker Compose (referencyjne).
  - **CI**: uruchamiaj w tym samym układzie usług (Docker Compose), aby odzwierciedlić lokalne wersje usług.

### 1.2 Baza danych
- **Typ**: PostgreSQL.
- **Wersja**: 17 (bazuje na `postgres:17` w Dockerfile).【F:compose/production/postgres/Dockerfile†L1-L5】

### 1.3 Usługi zależne
- **Redis/Celery**: dla testów `pytest` nie jest wymagany zewnętrzny broker.
  - `config.settings.test` uruchamia Celery **eager** i używa in-memory broker/result backend.【F:config/settings/test.py†L40-L55】
- **Inne usługi** (USOS, mapy, integracje zewnętrzne): **nie są używane** w fixture’ach ani w referencyjnym środowisku testowym.

### 1.4 Minimalny zestaw zmiennych środowiskowych
| Zmienna | Rola | Wartość referencyjna / default |
|---|---|---|
| `DJANGO_SETTINGS_MODULE` | Wybór konfiguracji Django | `config.settings.test` (pytest) lub `config.settings.local` (lokalny DB) |
| `DATABASE_URL` | Połączenie DB (PostgreSQL) | `postgres://...` z `.envs/.local/.postgres` |
| `DJANGO_SECRET_KEY` | Klucz sekretów | może pozostać domyślny w testach (ustawiany w settings)【F:config/settings/test.py†L11-L19】 |
| `REDIS_URL` | Broker/cache (opcjonalnie) | domyślnie `redis://redis:6379/0` (nieużywane w testach)【F:config/settings/base.py†L298-L298】 |
| `TZ` | Strefa czasowa OS | `Europe/Warsaw` (zgodnie z Django `TIME_ZONE`)【F:config/settings/base.py†L27-L27】 |

### 1.5 Konfiguracja Django dla testów
- **Domyślne ustawienia pytest**: `config.settings.test` (ustawione w `pyproject.toml`).【F:pyproject.toml†L1-L6】
- **Baza w testach**: in-memory SQLite (szybkie, deterministyczne).【F:config/settings/test.py†L21-L30】
- **TIME_ZONE**: `Europe/Warsaw` z konfiguracji bazowej.【F:config/settings/base.py†L27-L27】

> **Uwaga**: dla testów wymagających weryfikacji zachowania na PostgreSQL, uruchamiaj je jawnie z `config.settings.local` i `DATABASE_URL` (np. w dedykowanych testach integracyjnych).

---

## 2) Minimal fixtures set (deterministyczny)

Strategia: **Django JSON fixtures** w katalogach `pw_hub/fixtures` oraz `{app}/fixtures` z plikami `*_core.json`. Dane są stałe, z przewidywalnymi PK, slugami i datami.

### 2.1 Lista fixture’ów (minimalny kontrakt)

| Fixture | Lokalizacja | Opis | Zależności | Przewidywalne identyfikatory |
|---|---|---|---|---|
| `start_app.json` | `pw_hub/fixtures/` | Baza użytkowników, uprawnienia, główne jednostki (PW, wydziały), preferencje | brak | użytkownicy `admin` (pk=1), `wrs_staff` (pk=2), `announcements_team` (pk=3), `events_coordinator` (pk=4), `guides_editor` (pk=5) + jednostki pk=1–5【F:pw_hub/fixtures/start_app.json†L1-L160】 |
| `users_core.json` | `pw_hub/users/fixtures/` | Studenci (rola „student”) + preferencje | `start_app.json` | `student_anna`..`student_ewa` (pk=6–10)【F:pw_hub/users/fixtures/users_core.json†L1-L120】 |
| `units_core.json` | `pw_hub/units/fixtures/` | Dodatkowe jednostki organizacyjne | `start_app.json` | jednostki pk=6–10 (np. Dziekanat WEiTI, KNR)【F:pw_hub/units/fixtures/units_core.json†L1-L110】 |
| `announcements_core.json` | `pw_hub/announcements/fixtures/` | Kategorie i ogłoszenia w stanach *published/pending/draft* | `start_app.json` | kategorie pk=1–10 (slug stały), ogłoszenia z `status` m.in. `published`, `pending`, `draft`【F:pw_hub/announcements/fixtures/announcements_core.json†L1-L90】【F:pw_hub/announcements/fixtures/announcements_core.json†L100-L140】 |
| `events_core.json` | `pw_hub/events/fixtures/` | Kategorie wydarzeń, wydarzenia (różne daty, rejestracja tak/nie), rejestracje i bilety | `start_app.json` | kategorie pk=1–10, wydarzenia pk=1.. (np. z/bez rejestracji)【F:pw_hub/events/fixtures/events_core.json†L1-L120】 |
| `guides_core.json` | `pw_hub/guides/fixtures/` | Kategorie poradników, poradniki (published/unpublished), kontakty | `start_app.json` | kategorie pk=1–10, poradniki pk=1.., kontakty `guides.contact`【F:pw_hub/guides/fixtures/guides_core.json†L1-L120】【F:pw_hub/guides/fixtures/guides_core.json†L300-L360】 |
| `notifications_core.json` | `pw_hub/notifications/fixtures/` | Powiadomienia powiązane z eventami i ogłoszeniami | `start_app.json`, `announcements_core.json`, `events_core.json` | deterministyczne PK + `related_object` do eventów/ogłoszeń【F:pw_hub/notifications/fixtures/notifications_core.json†L1-L120】 |

### 2.2 Role użytkowników (minimalne pokrycie)
- **Anonim**: brak użytkownika (testy bez autoryzacji).
- **Student**: `student_anna` (pk=6).【F:pw_hub/users/fixtures/users_core.json†L1-L20】
- **Organizator**: `events_coordinator` (pk=4).【F:pw_hub/fixtures/start_app.json†L54-L74】
- **Administrator merytoryczny**: `announcements_team` (pk=3) lub `wrs_staff` (pk=2) – zależnie od scenariusza panelu treści.【F:pw_hub/fixtures/start_app.json†L28-L60】
- **Staff/Superuser**: `admin` (pk=1, `is_superuser=true`, `is_staff=true`).【F:pw_hub/fixtures/start_app.json†L1-L26】

---

## 3) Zasady deterministyczności

1. **Czas**
   - Używaj stałej daty w fixture’ach (już spełnione przez `*_core.json`).
   - W testach z `timezone.now()` zamrażaj czas na stałą wartość (np. `2025-06-01T12:00:00+02:00`) przez monkeypatch lub helper fixture.
2. **Losowość**
   - Ustaw `PYTHONHASHSEED=0`.
   - Gdy używasz factory_boy/Faker, seeduj generator (np. `factory.random.reseed_random(0)` w fixture testowej).
3. **Strefa czasowa**
   - Trzymaj się `Europe/Warsaw` (Django `TIME_ZONE`).【F:config/settings/base.py†L27-L27】
   - W CI ustaw `TZ=Europe/Warsaw`.
4. **Kolejność**
   - Testy nie mogą polegać na implicit ordering; używaj `order_by` lub asercji po kluczach.
5. **Izolacja**
   - Każdy test działa na świeżej transakcji; nie zakładaj danych z poprzedniego testu.

---

## 4) How to run tests + load fixtures

### 4.1 Lokalnie (referencyjne środowisko na PostgreSQL)
```bash
# 1) Uruchom DB
   docker compose -f docker-compose.local.yml up -d postgres

# 2) Migracje
   docker compose -f docker-compose.local.yml run --rm django python manage.py migrate

# 3) Załaduj minimalny zestaw fixtures
   docker compose -f docker-compose.local.yml run --rm django python manage.py loaddata \
     start_app units_core users_core announcements_core events_core guides_core notifications_core
```

### 4.2 Pytest (domyślnie SQLite in-memory)
```bash
# pytest używa config.settings.test
uv run pytest
```

> Jeśli test wymaga danych z fixtures, ładuj je jawnie w teście:
```python
from django.core.management import call_command

call_command("loaddata", "start_app", "announcements_core")
```

---

## 5) Plan walidacji odtwarzalności i stabilności

1. **Odtworzenie środowiska od zera**
   - Uruchom DB (`docker compose ... up -d postgres`).
   - Wykonaj migracje.
   - Załaduj minimalny zestaw fixtures (`start_app` + `*_core.json`).
   - Uruchom `pytest`.

2. **Stabilność**
   - Uruchom cały test suite **3x pod rząd**:
     - `uv run pytest` (powinny być identyczne wyniki).

3. **Porównywalność środowisk**
   - Potwierdź wersję PostgreSQL (`postgres:17`) w lokalnym i CI.
   - Upewnij się, że `TIME_ZONE` to `Europe/Warsaw` i `DJANGO_SETTINGS_MODULE` jest identyczny.

---

## 6) Źródła flakiness i ograniczenia (Telemetry Bounty Hunter)

**Główne ryzyka:**
- **Czas**: testy i logika opierają się na `timezone.now()` (widoczne w modelach, widokach i testach).【F:pw_hub/events/models.py†L220-L463】【F:pw_hub/announcements/models.py†L200-L205】
- **Losowość/Faker**: factory_boy generuje dane losowe (np. daty) bez stałego seeda.
- **Zależności zewnętrzne**: USOS/mapy nie mogą pojawiać się w fixture’ach (zakaz w kontrakcie).

**Ograniczenia według specyfikacji:**
- Zamrożony czas w testach, stałe daty w fixtures.
- Seedowanie losowości w testach.
- Brak zewnętrznych usług w fixture’ach.
- Jasna obserwowalność testów: w razie flakiness loguj `now()` i używany seed (np. w `conftest.py`).

---

## 7) Kontrakt użycia (skrót)

1. **Referencyjne środowisko**: Docker Compose + PostgreSQL 17.
2. **Minimalne fixtures**: `start_app` + `*_core.json` z katalogów appów.
3. **Deterministyczność**: zamrożony czas, seed losowości, stała TZ.
4. **Testy**: `uv run pytest` (SQLite) + integracyjne `loaddata` na PostgreSQL, jeśli potrzebne.

