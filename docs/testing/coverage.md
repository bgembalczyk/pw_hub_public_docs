# Coverage gates (CI)

## Purpose & audience

This document defines **coverage gates** for the PW Hub codebase.
It is for developers and reviewers who need deterministic, repeatable quality checks in CI.

## Source of truth

* Coverage configuration: `pyproject.toml` (coverage settings, report outputs).
* Coverage gate logic: `bin/check_coverage_gates.py` (threshold enforcement).
* CI wiring: `.gitlab-ci.yml` (coverage run + artifacts).

## Criticality map

Coverage is tracked **per module boundary** (not only global averages).
Critical modules have stricter gates to protect MVP flows and regressions.

| Module/Package | Criticality | Why | Coverage gate (line/branch) |
| --- | --- | --- | --- |
| `pw_hub/users/` + `pw_hub/menu_permissions.py` | **Critical** | Auth, roles, and user profile logic are core trust boundaries and identity flows. | **>= 75% / 65%** |
| `pw_hub/announcements/` | **Critical** | News/announcements are a core content surface for the MVP. | **>= 75% / 65%** |
| `pw_hub/events/` | **Critical** | Events are a core content surface and drive primary user journeys. | **>= 75% / 65%** |
| `pw_hub/guides/` | **Critical** | Guides are a core informational pillar for students. | **>= 75% / 65%** |
| `pw_hub/notifications/` | Important | Supports engagement but does not replace core content. | >= 65% / 55% (target, no CI gate yet) |
| `pw_hub/pages/` | Important | Presentation layer for content discovery. | >= 65% / 55% (target, no CI gate yet) |
| `pw_hub/maps/` | Non-critical | Auxiliary feature, not a primary MVP flow. | Report-only |
| `pw_hub/unit_panel/` | Non-critical | Internal admin/support functionality. | Report-only |

## Coverage thresholds

**Global gate (entire repo):**
* Line coverage **>= 55%**
* Branch coverage **>= 45%**

**Critical module gate:**
* Line coverage **>= 75%**
* Branch coverage **>= 65%**

These thresholds are intentionally **realistic starters** that can ratchet up over time.
They are enforced by `bin/check_coverage_gates.py` using `coverage.json` output.

## How to run locally

Run tests with coverage and enforce gates in one go:

```bash
docker compose -f docker-compose.local.yml run --rm django coverage run -m pytest
docker compose -f docker-compose.local.yml run --rm django coverage json -o coverage.json
docker compose -f docker-compose.local.yml run --rm django python bin/check_coverage_gates.py coverage.json
```

Generate human-friendly reports:

```bash
docker compose -f docker-compose.local.yml run --rm django coverage report
docker compose -f docker-compose.local.yml run --rm django coverage xml
docker compose -f docker-compose.local.yml run --rm django coverage html
```

Outputs:
* Terminal report: immediate visibility of missing lines.
* `coverage.xml`: CI-friendly output for integrations.
* `coverage_html/`: browsable HTML report.

## How to interpret reports

* **Line coverage**: percentage of executed statements.
* **Branch coverage**: percentage of executed decision branches.
* **Critical gates**: evaluated per module group, not as a global average.

If any gate fails, CI fails with a clear error from `bin/check_coverage_gates.py`.

## Changing thresholds

1. Propose a change in a PR (include rationale and current coverage snapshot).
2. Update both:
   * `bin/check_coverage_gates.py` thresholds.
   * This document’s table and threshold section.
3. Reviewers confirm changes align with MVP criticality and regression risk.

Never lower thresholds to “green the pipeline” without a clear mitigation plan.
