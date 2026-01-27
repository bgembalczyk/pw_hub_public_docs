# Diagrams Overview / Przegląd diagramów

This directory contains PlantUML diagrams and supporting documents that describe the PW_hub application created within the **Aplikacja Companion** project. When updating requirements or data models, keep these diagrams and comparison notes in sync. / Ten katalog zawiera diagramy PlantUML i dokumenty pomocnicze opisujące aplikację PW_hub tworzoną w ramach projektu **Aplikacja Companion**. Przy zmianach wymagań lub modeli danych aktualizuj diagramy i notatki porównawcze.

## Sources of truth / Źródła prawdy
- `docs/docs.md` – wymagania i koncepcja / requirements and concept
- `docs/specs.md` – specyfikacja funkcjonalna / functional specification
- `docs/MOCKUPY.md` – mapowanie mock-upów i paneli / mock-up mapping

## Diagram and document inventory / Spis diagramów i dokumentów

### Database / Baza danych
- `database.puml` – original/legacy schema.
- `database_new.puml` – extended schema aligned with current requirements.
- `DATABASE_COMPARISON.md` / `POROWNANIE_BAZ_DANYCH.md` – comparison notes between `database.puml` and `database_new.puml` (keep updated when the schema evolves).

### Use cases / Przypadki użycia
- `use_case.puml` – use case diagram covering mobile app, Django panels, and external integrations.

### Architecture / Architektura
- `component_diagram.puml` – component-level architecture.
- `deployment_diagram.puml` – deployment architecture.
- `app_hierarchy.puml` – hierarchy of applications/modules.

### Domain models / Modele domenowe
- `announcements_models.puml` – announcement domain model.
- `guides_class_diagram.puml` – guides domain model.

### CI/CD and migration checks / CI/CD i kontrola migracji
- `migration-checks-flow.puml` – CI flow for migration checks.
- `migration-checks-coverage.puml` – coverage of migration checks.

## How to view / Jak wyświetlić

To generate an image from a PlantUML file / Aby wygenerować obraz z pliku PlantUML:

```bash
plantuml docs/diagrams/<file>.puml
```

Or use any PlantUML-compatible viewer or IDE plugin / Lub użyj edytora zgodnego z PlantUML lub wtyczki IDE.
