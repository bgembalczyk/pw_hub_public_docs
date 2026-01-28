# Events API

This document describes the API endpoints for the Events application, including Ticket management.

**Response Envelope Status:** **Legacy (raw payload)** — to be migrated to the
standard envelope. See [API Response Envelope](./response_envelope.md).

## Tickets

Tickets are digital proofs of registration for an event. They contain a unique code and a QR code.

### List Tickets

Get a list of tickets belonging to the authenticated user.

**Endpoint:** `GET /api/tickets/`

**Permissions:** Authenticated user (Owner only)

**Envelope:** Legacy (raw list)

**Response (legacy):**
```json
[
  {
    "id": 1,
    "ticket_code": "550e8400-e29b-41d4-a716-446655440000",
    "event_title": "Python Workshop",
    "event_start_time": "2023-10-15T10:00:00Z",
    "event_end_time": "2023-10-15T12:00:00Z",
    "event_location": "Building A, Room 101",
    "participant_name": "John Doe",
    "participant_id_number": "123456",
    "issued_at": "2023-10-01T12:00:00Z",
    "scanned_at": null,
    "is_valid": true,
    "qr_code_url": "http://example.com/media/tickets/qr_codes/ticket_550e8400.png",
    "qr_code_base64": "iVBORw0KGgoAAAANSUhEUgAA..."
  }
]
```

### Retrieve Ticket

Get details of a specific ticket.

**Endpoint:** `GET /api/tickets/{id}/`

**Permissions:** Authenticated user (Owner only)

**Envelope:** Legacy (raw object)

**Response (legacy):** Same as list item, includes `qr_code_base64`.

### Download Ticket

Download ticket details with Base64 QR code for offline storage.

**Endpoint:** `GET /api/tickets/{id}/download/`

**Permissions:** Authenticated user (Owner only)

**Envelope:** Legacy (raw object)

**Response (legacy):** Same as retrieve.

### Verify Ticket

Verify a ticket's validity. Used by event organizers.

**Endpoint:** `POST /api/tickets/verify/`

**Permissions:** Authenticated user (Event Organizer or Staff)

**Request Body:**
```json
{
  "ticket_code": "550e8400-e29b-41d4-a716-446655440000"
}
```

**Response (Success):**
```json
{
  "valid": true,
  "message": "Ticket verified successfully",
  "ticket": { ... },
  "scanned_at": "2023-10-15T10:05:00Z"
}
```

## Error responses (standard)

### Validation error (400)

```json
{
  "errors": [
    {
      "code": "VALIDATION_ERROR",
      "message": "Validation failed.",
      "field": "ticket_code"
    }
  ]
}
```

### Conflict (409) — already registered

```json
{
  "errors": [
    {
      "code": "CONFLICT",
      "message": "User is already registered for this event."
    }
  ]
}
```

### Forbidden vs Not Found (403/404) — verify ticket

Use 403 when the organizer is authenticated but not allowed to verify, and
404 when the ticket is intentionally hidden (anti-enumeration).

```json
{
  "errors": [
    {
      "code": "FORBIDDEN",
      "message": "You do not have permission to verify this ticket."
    }
  ]
}
```

```json
{
  "errors": [
    {
      "code": "NOT_FOUND",
      "message": "Ticket not found."
    }
  ]
}
```

### Conflict (409) — already scanned

```json
{
  "errors": [
    {
      "code": "ALREADY_USED",
      "message": "Ticket was already scanned."
    }
  ]
}
```

**Envelope:** Legacy (custom object)

## Error Responses (Legacy Shape)

Typical validation error (DRF default):

```json
{
  "ticket_code": [
    "This field is required."
  ]
}
```


> **Legacy note:** `/api/tickets/verify/` currently returns 200 with a
> `status`/`message` body even for invalid tickets. This should be migrated to
> the standard error envelope as part of Stage 3 in the migration plan.【F:pw_hub/events/api/views.py†L349-L382】
