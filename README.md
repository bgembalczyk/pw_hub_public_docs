# PW_hub (projekt: Aplikacja Companion)

Aplikacja informacyjna typu Companion od studentów dla studentów PW. **Aplikacja Companion** to oficjalna nazwa projektu, **PW_hub** to robocza/deweloperska nazwa aplikacji powstającej w ramach projektu, a nazwa marketingowa zostanie ustalona później.

[![Built with Cookiecutter Django](https://img.shields.io/badge/built%20with-Cookiecutter%20Django-ff69b4.svg?logo=cookiecutter)](https://github.com/cookiecutter/cookiecutter-django/)
[![Ruff](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/astral-sh/ruff/main/assets/badge/v2.json)](https://github.com/astral-sh/ruff)

License: MIT

## 📚 Documentation / Dokumentacja

### Project Documentation / Dokumentacja Projektu

- **[Requirements & Concept](docs/docs.md)** - Wymagania i koncepcja wdrożenia
- **[Functional Specification](docs/specs.md)** - Specyfikacja funkcjonalna
- **[Development Guidelines](agents.md)** - Wytyczne dla developerów
- **[Mock-ups Documentation](docs/MOCKUPY.md)** - ⭐ Dokumentacja mock-upów i paneli administracyjnych

### Mock-ups / Mock-upy

- **[Flutter App Mock-ups](docs/mock/)** - Mock-upy aplikacji mobilnej dla studentów (HTML)
- **[Django Panels Mock-ups](docs/mock_django/)** - Mock-upy paneli Django (PlantUML)

### Database & Diagrams / Baza Danych i Diagramy

- **[Database Diagrams](docs/diagrams/)** - Diagramy bazy danych i przypadków użycia

## Settings

Moved to [settings](https://cookiecutter-django.readthedocs.io/en/latest/1-getting-started/settings.html).

## Basic Commands

### Setting Up Your Users

- To create a **normal user account**, just go to Sign Up and fill out the form. Once you submit it, you'll see a "Verify Your E-mail Address" page. Go to your console to see a simulated email verification message. Copy the link into your browser. Now the user's email should be verified and ready to go.

- To create a **superuser account**, use this command:

      uv run python manage.py createsuperuser

For convenience, you can keep your normal user logged in on Chrome and your superuser logged in on Firefox (or similar), so that you can see how the site behaves for both kinds of users.

### Type checks

Running type checks with mypy:

    uv run mypy pw_hub

### Test coverage

To run the tests, check your test coverage, and generate an HTML coverage report:

    uv run coverage run -m pytest
    uv run coverage html
    uv run open htmlcov/index.html

#### Running tests with pytest

    uv run pytest

### Live reloading and Sass CSS compilation

Moved to [Live reloading and SASS compilation](https://cookiecutter-django.readthedocs.io/en/latest/2-local-development/developing-locally.html#using-webpack-or-gulp).

### Migrations

When working with Django migrations in this project:

- **Always create migrations** after changing models: `just makemigrations`
- **Never edit existing migrations** that have been merged to main
- **CI checks**: Two complementary checks protect migration integrity:
  - `migrations-integritycheck`: Prevents editing of existing migration files
  - `makemigrations-check`: Ensures all model changes have corresponding migrations

For detailed information about the CI migration checks, see [docs/ci-migration-checks-analysis.md](docs/ci-migration-checks-analysis.md).

## Deployment

The following details how to deploy this application.

### Docker

See detailed [cookiecutter-django Docker documentation](https://cookiecutter-django.readthedocs.io/en/latest/3-deployment/deployment-with-docker.html).
