# Student Profile API

This document describes the API endpoints for storing and retrieving the student profile
used by onboarding personalization.

## Student Profile

The student profile stores a minimal set of data:
- `faculty` (required)
- `study_year` (required)
- `study_group` (optional)

### Retrieve Student Profile

Get the profile for the authenticated student.

**Endpoint:** `GET /api/student-profile/`

**Permissions:** Authenticated user (Owner only)

**Response (200 OK):**
```json
{
  "id": 12,
  "user_id": 431,
  "faculty": "Wydział Elektroniki i Technik Informacyjnych",
  "study_year": 2,
  "study_group": "EITI-2A",
  "updated_at": "2024-05-10T12:00:00Z"
}
```

**Response (404 Not Found):**
```json
{
  "detail": "Student profile not found"
}
```

### Create or Update Student Profile (Onboarding)

Create or replace the profile for the authenticated student.

**Endpoint:** `PUT /api/student-profile/`

**Permissions:** Authenticated user (Owner only)

**Request Body:**
```json
{
  "faculty": "Wydział Elektroniki i Technik Informacyjnych",
  "study_year": 2,
  "study_group": "EITI-2A"
}
```

**Response (200 OK):**
```json
{
  "id": 12,
  "user_id": 431,
  "faculty": "Wydział Elektroniki i Technik Informacyjnych",
  "study_year": 2,
  "study_group": "EITI-2A",
  "updated_at": "2024-05-10T12:05:00Z"
}
```

**Response (400 Bad Request):**
```json
{
  "errors": [
    {
      "code": "validation_error",
      "field": "faculty",
      "message": "This field is required."
    }
  ]
}
```

### Partial Update Student Profile

Update selected fields without replacing the entire profile.

**Endpoint:** `PATCH /api/student-profile/`

**Permissions:** Authenticated user (Owner only)

**Request Body:**
```json
{
  "study_group": null
}
```

**Response (200 OK):** Same as `PUT`.

## Notes

- `study_group` is optional and may be `null`.
- Data dictionaries for faculties, years, and groups are provided by a separate catalog
  (non-API scope in P1).
