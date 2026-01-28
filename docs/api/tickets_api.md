# Tickets & Verification API

## Cel i zakres

Tickets API zapewnia mobilnej aplikacji dostęp do wejściówek użytkownika oraz
endpoint do weryfikacji wejściówek przez organizatora wydarzenia.
Dokument opisuje rzeczywiste zachowanie API zgodne z implementacją w Django/DRF.

**Konsumenci:**
- Aplikacja mobilna (Flutter) – lista i szczegóły wejściówek, tryb offline.
- Panel web (unit panel) – weryfikacja wejściówek korzysta z tego samego serwisu
  w backendzie, ale nie musi używać publicznego endpointu REST.

**Non-goals:**
- UI/UX w aplikacji mobilnej lub panelu.
- Generowanie kodu QR w panelu (to proces backendowy).
- Zmiany w logice uprawnień (tylko dokumentacja).

## Autoryzacja i role

**Auth:**
- Wymagane uwierzytelnienie (Session Authentication lub Token Authentication).
- Domyślna polityka DRF to `IsAuthenticated`, więc brak autoryzacji zwraca 403.

**Role i uprawnienia (as implemented):**

| Endpoint | Kto ma dostęp | Uwagi bezpieczeństwa |
| --- | --- | --- |
| `GET /api/tickets/` | Zalogowany użytkownik (właściciel) | Queryset filtrowany po `registration.user`; brak enumeracji cudzych wejściówek. |
| `GET /api/tickets/{id}/` | Właściciel wejściówki | Dla cudzych ID zwracane jest 404 (anty-enumeracja). |
| `GET /api/tickets/{id}/download/` | Właściciel wejściówki | Tak samo jak detail – 404 dla cudzych ID. |
| `POST /api/tickets/verify/` | Organizator wydarzenia lub staff | Weryfikacja sprawdzana w serwisie, brak dostępu → 403. |

**PII/bezpieczeństwo:**
- Detail i download zwracają dane uczestnika (`participant_name`, `participant_id_number`),
  dlatego dostęp jest ograniczony do właściciela.
- Verify zwraca pełny obiekt Ticket (z danymi uczestnika) tylko dla organizatora/staff.

## Modele danych (API)

### Ticket (detail/download)
| Pole | Typ | Null | Opis |
| --- | --- | --- | --- |
| `id` | int | no | ID wejściówki |
| `ticket_code` | UUID (string) | no | Kod wejściówki (QR) |
| `event_id` | int | no | ID wydarzenia |
| `event_title` | string | no | Tytuł wydarzenia |
| `event_start_time` | datetime | no | Start wydarzenia (ISO 8601) |
| `event_end_time` | datetime | no | Koniec wydarzenia (ISO 8601) |
| `event_location` | string | yes | Nazwa lokacji (stringified Unit) |
| `participant_name` | string | yes | Imię i nazwisko uczestnika |
| `participant_id_number` | string | yes | Numer identyfikacyjny uczestnika |
| `issued_at` | datetime | no | Data wystawienia |
| `scanned_at` | datetime | yes | Data zeskanowania (jeśli użyta) |
| `is_valid` | bool | no | Flaga ważności |
| `qr_code_url` | string | yes | URL do PNG QR (może być absolute) |
| `qr_code_base64` | string | yes | QR jako base64 (PNG) do offline |

### TicketListItem (list)
| Pole | Typ | Null | Opis |
| --- | --- | --- | --- |
| `id` | int | no | ID wejściówki |
| `ticket_code` | UUID (string) | no | Kod wejściówki |
| `status` | enum | no | `valid` / `used` / `invalid` |
| `scanned_at` | datetime | yes | Data skanowania |
| `event` | object | no | Zagnieżdżone dane wydarzenia |

**TicketListItem.event:**
- `id` (int)
- `title` (string)
- `starts_at` (datetime)
- `ends_at` (datetime)
- `location` (object: `id`, `name`, `short_name`)

### VerificationResult (verify)
| Pole | Typ | Null | Opis |
| --- | --- | --- | --- |
| `valid` | bool | no | Czy weryfikacja zakończyła się sukcesem |
| `message` | string | no | Komunikat użytkowy |
| `ticket` | object (Ticket) | yes | Dołączany, gdy ticket istnieje |
| `scanned_at` | datetime | yes | Czas skanowania (użyty/po weryfikacji) |

## Endpointy

### 1) Lista wejściówek użytkownika

**GET** `/api/tickets/`

**Auth:** wymagane (Session/Token)

**Uprawnienia:** właściciel (tylko własne wejściówki)

**Response: 200 OK**
```json
[
  {
    "id": 120,
    "ticket_code": "550e8400-e29b-41d4-a716-446655440000",
    "status": "valid",
    "scanned_at": null,
    "event": {
      "id": 45,
      "title": "Python Workshop",
      "starts_at": "2024-10-15T10:00:00Z",
      "ends_at": "2024-10-15T12:00:00Z",
      "location": {
        "id": 3,
        "name": "Building A",
        "short_name": "A"
      }
    }
  }
]
```

### 2) Szczegóły wejściówki

**GET** `/api/tickets/{id}/`

**Auth:** wymagane

**Uprawnienia:** właściciel

**Response: 200 OK**
```json
{
  "id": 120,
  "ticket_code": "550e8400-e29b-41d4-a716-446655440000",
  "event_id": 45,
  "event_title": "Python Workshop",
  "event_start_time": "2024-10-15T10:00:00Z",
  "event_end_time": "2024-10-15T12:00:00Z",
  "event_location": "Building A",
  "participant_name": "Jan Kowalski",
  "participant_id_number": "123456",
  "issued_at": "2024-10-01T12:00:00Z",
  "scanned_at": null,
  "is_valid": true,
  "qr_code_url": "https://hub.pw.edu.pl/media/tickets/qr_codes/ticket_550e8400.png",
  "qr_code_base64": "iVBORw0KGgoAAAANSUhEUgAA..."
}
```

### 3) Pobranie wejściówki do offline

**GET** `/api/tickets/{id}/download/`

**Auth:** wymagane

**Uprawnienia:** właściciel

**Response: 200 OK**
- Struktura identyczna jak `GET /api/tickets/{id}/`.
- `qr_code_base64` może być `null`, jeśli plik QR jest niedostępny.

### 4) Weryfikacja wejściówki (organizator)

**POST** `/api/tickets/verify/`

**Auth:** wymagane

**Uprawnienia:** organizator wydarzenia (`event.created_by`) lub staff.

**Request Body:**
```json
{
  "ticket_code": "550e8400-e29b-41d4-a716-446655440000"
}
```

**Response: 200 OK (valid)**
```json
{
  "valid": true,
  "message": "Ticket verified successfully",
  "ticket": {
    "id": 120,
    "ticket_code": "550e8400-e29b-41d4-a716-446655440000",
    "event_id": 45,
    "event_title": "Python Workshop",
    "event_start_time": "2024-10-15T10:00:00Z",
    "event_end_time": "2024-10-15T12:00:00Z",
    "event_location": "Building A",
    "participant_name": "Jan Kowalski",
    "participant_id_number": "123456",
    "issued_at": "2024-10-01T12:00:00Z",
    "scanned_at": "2024-10-15T10:05:00Z",
    "is_valid": true,
    "qr_code_url": "https://hub.pw.edu.pl/media/tickets/qr_codes/ticket_550e8400.png",
    "qr_code_base64": "iVBORw0KGgoAAAANSUhEUgAA..."
  },
  "scanned_at": "2024-10-15T10:05:00Z"
}
```

**Response: 200 OK (already scanned / invalid)**
```json
{
  "valid": false,
  "message": "Ticket was already scanned",
  "ticket": {
    "id": 120,
    "ticket_code": "550e8400-e29b-41d4-a716-446655440000",
    "event_id": 45,
    "event_title": "Python Workshop",
    "event_start_time": "2024-10-15T10:00:00Z",
    "event_end_time": "2024-10-15T12:00:00Z",
    "event_location": "Building A",
    "participant_name": "Jan Kowalski",
    "participant_id_number": "123456",
    "issued_at": "2024-10-01T12:00:00Z",
    "scanned_at": "2024-10-15T10:05:00Z",
    "is_valid": true,
    "qr_code_url": "https://hub.pw.edu.pl/media/tickets/qr_codes/ticket_550e8400.png",
    "qr_code_base64": "iVBORw0KGgoAAAANSUhEUgAA..."
  },
  "scanned_at": "2024-10-15T10:05:00Z"
}
```

## Błędy i kody odpowiedzi

| Status | Kiedy | Przykład odpowiedzi |
| --- | --- | --- |
| `400 Bad Request` | Niepoprawny format `ticket_code` (nie-UUID) | `{"ticket_code":["Must be a valid UUID."]}` |
| `403 Forbidden` | Brak autoryzacji lub brak uprawnień do weryfikacji | `{"detail":"Authentication credentials were not provided."}` lub `{"valid":false,"message":"Only event organizers can verify tickets"}` |
| `404 Not Found` | Ticket nie istnieje lub obcy `id` w detail/download | `{"valid":false,"message":"Ticket not found"}` |
| `200 OK` | Weryfikacja negatywna (invalid/used) | `{"valid":false,"message":"Ticket was already scanned"}` |
| `500 Internal Server Error` | Błąd serwera | (bez szczegółów) |

> Uwaga: w implementacji negatywne przypadki weryfikacji (`invalid`, `used`) zwracają 200 OK
> z `valid: false` – to świadome zachowanie kontraktu „as implemented”.

## Przykłady użycia (mobile-friendly)

### A) Pobierz listę wejściówek i pokaż
1. `GET /api/tickets/`
2. Renderuj listę na podstawie `event.title`, `event.starts_at`, `status`.
3. Przy kliknięciu przejdź do detail.

### B) Pobierz wejściówkę do offline
1. `GET /api/tickets/{id}/download/`
2. Zapisz payload lokalnie (w tym `qr_code_base64`).
3. W trybie offline wyświetl `event_title`, `event_start_time`, `event_location` + QR.

### C) Weryfikuj ticket_code na wejściu
1. Zeskanuj QR → odczytaj `ticket_code`.
2. `POST /api/tickets/verify/` z `ticket_code`.
3. Jeśli `valid: true` → wpuszczaj; jeśli `valid: false` → pokaż `message`.

## Spec vs Implementation

1. **Lista wejściówek**
   - Spec sugeruje „pełne metadane wydarzenia”.
   - Implementacja listy zwraca **zminimalizowany** payload z obiektem `event`
     i polem `status`, bez `qr_code_base64` oraz bez danych uczestnika.
   - Rekomendacja dla mobile: korzystać z listy do przeglądu, a szczegóły dociągać
     z detail/download.

2. **Statusy HTTP weryfikacji**
   - Spec nie precyzuje kodów dla `invalid`/`used`.
   - Implementacja zwraca **200 OK** z `valid: false` w tych przypadkach
     (nie używa 409/422).

3. **Brak 401 w praktyce**
   - Brak autoryzacji dla tych endpointów zwraca 403 (DRF + Session/Token auth).
   - Mobile powinien traktować 403 jako brak autoryzacji i odświeżyć token/session.

## QA / Checklist weryfikacyjna

### Minimalne AC (backend + mobile)
- [ ] Każdy endpoint ma opisane: method/path, auth, status codes, przykład success.
- [ ] Lista `GET /api/tickets/` zwraca `status` oraz obiekt `event`.
- [ ] Detail/download zwracają `qr_code_base64` (może być null).
- [ ] Verify zwraca `valid` + `message` i 200 OK dla `used/invalid`.
- [ ] Brak wycieku PII do użytkownika bez uprawnień (404 dla cudzych ticketów).

### Mini contract tests (Given/When/Then)
- **Given** zalogowany użytkownik z 2 wejściówkami, **When** `GET /api/tickets/`,
  **Then** lista zawiera tylko jego wejściówki i pola `status`/`event`.
- **Given** wejściówka innego użytkownika, **When** `GET /api/tickets/{id}/`,
  **Then** response = 404.
- **Given** organizator wydarzenia i ważna wejściówka, **When** `POST /api/tickets/verify/`,
  **Then** response 200 z `valid: true` i uzupełnionym `scanned_at`.
- **Given** wejściówka już zeskanowana, **When** `POST /api/tickets/verify/`,
  **Then** response 200 z `valid: false` i `message` informującym o użyciu.
