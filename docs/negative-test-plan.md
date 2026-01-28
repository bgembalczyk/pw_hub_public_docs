# Negative cases & error handling – Test Plan (MVP)

## 1. Cel i zakres
Celem dokumentu jest zdefiniowanie **spójnych scenariuszy negatywnych** oraz
**testowalnego zachowania błędów** dla kluczowych flow MVP (Student / Organizator /
Administrator), z mapowaniem do AC i User Stories.

Zakres obejmuje:
- walidację danych wejściowych (400),
- uprawnienia i bezpieczne ujawnianie zasobów (401/403/404),
- konflikty domenowe (409),
- degradację integracji zewnętrznych (5xx),
- spójne formaty błędów (minimalne, bez ujawniania detali technicznych).

## 2. Taksonomia błędów i minimalny format odpowiedzi

### 2.1. Ogólne zasady
- **Brak wycieku szczegółów technicznych** do użytkownika.
- **Błędy logowane po stronie serwera** (z kontekstem i identyfikatorem żądania).
- **Deterministyczne mapowanie**: ten sam błąd → ten sam status i code.

### 2.2. Statusy HTTP (MVP)
| Kategoria | Status | Kiedy | Uwagi |
| --- | --- | --- | --- |
| Walidacja | 400 | Format/typ danych niepoprawny, brak wymaganych pól | Standard DRF (field errors). |
| Walidacja semantyczna | 422 | Niespójność domenowa danych (opcjonalnie) | Rezerwujemy na kolejne iteracje. |
| Autentykacja | 401 | Brak ważnego uwierzytelnienia | W DRF w MVP zwykle 403 dla niezalogowanych. |
| Autoryzacja | 403 | Brak uprawnień do akcji/zasobu | Dla „twardej” odmowy dostępu. |
| Ukrycie zasobu | 404 | „Bezpieczne 404” dla cudzych zasobów | Chroni przed enumeracją. |
| Konflikt | 409 | Duplikaty, brak miejsc, kolizje stanu | Np. ponowny zapis. |
| Limit | 429 | Przekroczony limit | Jeśli wprowadzone rate limit. |
| Błąd serwera | 500 | Błąd wewnętrzny | Nie ujawniamy szczegółów. |
| Zależności | 502/503/504 | Błąd upstream/timeout | Degradacja + log. |

### 2.3. Minimalny format odpowiedzi błędu
#### API DRF (większość endpointów)
- Walidacja: standardowy format DRF, np.
  - `{"field": ["error message"]}`
- Błąd domenowy: `{"detail": "..."}`

#### Ticket verification (action)
- Odpowiedź minimalna:
  - `{"valid": false, "message": "..."}`
- Dodatkowo:
  - `ticket` i `scanned_at` tylko gdy mają sens domenowy.

## 3. Scenariusze negatywne – Student (API)

### 3.1. Tabela scenariuszy (Student)
| Scenario | Preconditions | Action | Expected result | HTTP status | Error code | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| Brak tokenu SSO | Brak sesji/uwierzytelnienia | Wejście do API z akcją wymagającą auth | Odrzucenie dostępu | 401/403 | `auth_required` | W DRF MVP: 403. |
| Nieważny token SSO | Token wygasły/nieważny | Próbuj wykonać akcję | Odrzucenie | 401/403 | `auth_invalid` | Bez detali technicznych. |
| Lista wydarzeń – nieistniejący event | Event ID nie istnieje | GET /api/events/{id}/ | Brak zasobu | 404 | `not_found` | Public endpoint. |
| Filtry – niepoprawny format | `availability` poza słownikiem | GET /api/events/?availability=foo | Brak filtrowania / neutralny wynik | 200 | `n/a` | Zachowanie jawnie akceptowane. |
| Zapis na wydarzenie – brak auth | Brak logowania | POST /api/events/{id}/register/ | Odrzucenie | 403 | `auth_required` | DRF default. |
| Zapis – niepoprawny email | Auth OK | POST z `participant_email=invalid` | Błąd walidacji pola | 400 | `validation_error` | DRF field error. |
| Zapis – dodatkowe pola | Auth OK | POST z nieznanym polem | Błąd walidacji | 400 | `validation_error` | Odrzucamy unknown fields. |
| Zapis – brak miejsc | Brak miejsc | POST /register/ | Konflikt domenowy / waitlist | 409 lub 200 | `capacity_conflict` | MVP: waitlist = 200. |
| Ponowny zapis | Użytkownik już zapisany | POST /register/ | Konflikt domenowy | 409 | `already_registered` | DRF detail. |
| Rezygnacja – brak rejestracji | Brak zapisu | POST /unregister/ | Brak zasobu | 404 | `registration_not_found` | |
| Ticket list – brak auth | Brak logowania | GET /api/tickets/ | Odrzucenie | 403 | `auth_required` | |
| Ticket detail – cudzy zasób | Zalogowany, cudzy ticket | GET /api/tickets/{id}/ | Bezpieczne 404 | 404 | `not_found` | Brak ujawniania istnienia. |

## 4. Scenariusze negatywne – Organizator (API + panel)

### 4.1. Tabela scenariuszy (Organizator)
| Scenario | Preconditions | Action | Expected result | HTTP status | Error code | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| Weryfikacja ticketu bez roli | Zalogowany, nie organizer/staff | POST /api/tickets/verify/ | Odrzucenie | 403 | `permission_denied` | Bez detali technicznych. |
| Ticket nie istnieje | Auth OK | POST /api/tickets/verify/ | Brak zasobu | 404 | `not_found` | |
| Ticket już zeskanowany | Auth OK | POST /api/tickets/verify/ | Valid=false | 200 | `already_scanned` | Specjalny format endpointu. |
| Ticket nieważny | Auth OK | POST /api/tickets/verify/ | Valid=false | 200 | `invalid_ticket` | |
| Panel Django – brak uprawnień | Brak permission | GET CRUD view | Odrzucenie | 403/302 | `permission_denied` | 302 → login. |
| Panel Django – cudzy event | Inna jednostka | GET participants | Brak zasobu | 404 | `not_found` | Chroni przed enumeracją. |

## 5. Scenariusze negatywne – Administrator (panel)

### 5.1. Tabela scenariuszy (Admin)
| Scenario | Preconditions | Action | Expected result | HTTP status | Error code | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| Brak uprawnień do moderacji | Zalogowany, brak perm | GET/POST moderacja | Odrzucenie | 403 | `permission_denied` | |
| Błędne dane formularza | Auth OK | POST z brakami | Walidacja | 200/400 | `validation_error` | Panel: re-render z błędami. |
| Nieistniejąca treść | Zły ID | GET/POST | Brak zasobu | 404 | `not_found` | |

## 6. External dependencies failures (granice integracji)

### 6.1. Tabela scenariuszy – integracje
| Dependency | Failure mode | Action | Expected result | HTTP status | Error code | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| IdP/SSO | Timeout / 5xx | Login | Czytelny komunikat + retry | 502/504 | `upstream_auth_error` | Brak detali technicznych. |
| USOS (read-only) | 4xx/5xx | Pobranie danych | Degradacja informacyjna | 502/503 | `upstream_usos_error` | Zachować używalność app. |
| Powiadomienia | 5xx | Wysłanie | Brak crasha, log | 502/503 | `upstream_notifications_error` | Retry tylko jeśli idempotentne. |
| Mapy | Timeout | Otwórz mapę | Fallback (brak danych) | 503/504 | `upstream_maps_error` | Komunikat bez detali. |

## 7. Mapowanie do User Stories i AC

| Obszar | User Stories | AC | Uwagi |
| --- | --- | --- | --- |
| Rejestracja / zapisy / wejściówki | STU-01, STU-07, STU-08 | AC-4, AC-3 | Negatywne scenariusze auth + conflicts. |
| Lista i filtry wydarzeń | STU-04, STU-05, STU-06 | AC-5 | Błędy filtrów → zachowanie deterministyczne. |
| Weryfikacja wejściówek | ORG-05 | AC-4 | 403/404/valid=false. |
| CRUD paneli Django | ORG-01..ORG-06, ADM-01..ADM-04 | AC-4, AC-6 | 403/404, walidacja formularzy. |
| Integracje zewnętrzne | STU-11, STU-10 | AC-3 | Degradacja + logowanie. |

## 8. Definition of Done – testy negatywne
- Pokrycie testami **unit + integration** dla walidacji, auth i konfliktów.
- Co najmniej 1 test na każdą klasę błędu w krytycznych flow.
- Brak niejawnych wyjątków i „cichych” błędów.
- Logowanie błędów integracji bez ujawniania detali.
- Spójne mapowanie status → format → code zgodnie z dokumentem.

## 9. Doc impact (gdzie uzupełnić wymagania)
- `docs/specs.md`: sekcja „Obsługa błędów i przypadki negatywne (MVP)”.
- `docs/analysis/acceptance-criteria-analysis.md`: AC dot. obsługi błędów i walidacji.
- Ten dokument jest referencją dla testów automatycznych (unit/integration).
