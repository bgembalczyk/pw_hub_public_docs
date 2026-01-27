# Code Quality and Pre-commit Guidelines for PW_hub

## Overview

All code must comply with the project's code quality standards as defined in `.pre-commit-config.yaml`.

## Pre-commit Hooks

**CRITICAL**: After making ANY code changes, you MUST run pre-commit to ensure compliance:

```bash
pre-commit run --show-diff-on-failure --color=always --all-files
```

This command will:
- Show you what changes the hooks made
- Display clear errors if there are issues
- Automatically fix many issues (formatting, trailing whitespace, etc.)
- Ensure your code meets the project's standards

## What Pre-commit Checks

The project uses the following pre-commit hooks:

### 1. Basic File Checks

- **trailing-whitespace**: Removes trailing whitespace
- **end-of-file-fixer**: Ensures files end with a newline
- **check-json**: Validates JSON files
- **check-toml**: Validates TOML files
- **check-xml**: Validates XML files
- **check-yaml**: Validates YAML files
- **debug-statements**: Detects debug statements (like `pdb`, `breakpoint()`)
- **check-builtin-literals**: Checks for built-in literals
- **check-case-conflict**: Checks for case conflicts in filenames
- **check-docstring-first**: Ensures docstrings come first in modules
- **detect-private-key**: Detects private keys in code

### 2. Django Upgrade

- **django-upgrade**: Automatically upgrades Django code to use Django 5.2+ patterns
  - Updates deprecated imports
  - Modernizes Django patterns
  - Ensures compatibility with Django 5.2

### 3. Ruff (Linting and Formatting)

- **ruff-check**: Lints Python code
  - Checks for code style issues
  - Enforces best practices
  - Detects common errors
  - Fixes issues automatically when possible
- **ruff-format**: Formats Python code
  - Consistent code formatting
  - Similar to Black formatter
  - Automatic formatting

### 4. djLint (Template Linting)

- **djlint-reformat-django**: Reformats Django templates
  - Consistent template formatting
  - Proper indentation
- **djlint-django**: Lints Django templates
  - Checks template syntax
  - Enforces template best practices

## Running Quality Checks Manually

### Run all pre-commit hooks
```bash
pre-commit run --show-diff-on-failure --color=always --all-files
```

### Run specific hook
```bash
pre-commit run ruff-check --all-files
pre-commit run ruff-format --all-files
```

### Run linting only
```bash
uv run ruff check .
```

### Run formatting only
```bash
uv run ruff format .
```

### Run type checking
```bash
uv run mypy pw_hub
```

### Run all tests
```bash
uv run pytest
```

### Run tests with coverage
```bash
uv run coverage run -m pytest
uv run coverage html
```

## Pre-commit Installation

If pre-commit is not installed:

```bash
# Install pre-commit hooks
pre-commit install

# Update hooks to latest versions
pre-commit autoupdate
```

## Common Issues and Solutions

### Trailing Whitespace

**Issue**: Lines have trailing spaces

**Solution**: The hook automatically removes them. Just stage the changes.

### Missing Docstrings

**Issue**: Module, class, or function is missing a docstring

**Solution**: Add a docstring at the beginning:
```python
"""
This is a module docstring.
"""

class MyClass:
    """This is a class docstring."""
    pass
```

### Import Order

**Issue**: Imports are not in the correct order

**Solution**: Ruff will automatically sort them. The order should be:
1. Standard library imports
2. Django imports
3. Third-party imports
4. Local imports

**Rule**: Use absolute imports only. Avoid relative imports like `from .` or `from ..`.

### Line Length

**Issue**: Lines are too long (> 88 characters for code, > 120 for docstrings)

**Solution**: Break the line:
```python
# Bad
some_function_call(argument1, argument2, argument3, argument4, argument5, argument6)

# Good
some_function_call(
    argument1,
    argument2,
    argument3,
    argument4,
    argument5,
    argument6,
)
```

### Debug Statements

**Issue**: Code contains `pdb.set_trace()` or `breakpoint()`

**Solution**: Remove debug statements before committing:
```python
# Bad
def my_function():
    breakpoint()  # Remove this
    return "result"

# Good
def my_function():
    return "result"
```

## Type Checking with mypy

The project uses mypy for type checking. Use type hints:

```python
# Good
def get_user_announcements(user: User, days: int = 30) -> QuerySet:
    """
    Retrieve announcements created by a user within specified days.

    Args:
        user: The user whose announcements to retrieve
        days: Number of days to look back (default: 30)

    Returns:
        QuerySet of Announcement objects
    """
    cutoff = timezone.now() - timedelta(days=days)
    return Announcement.objects.filter(author=user, created_at__gte=cutoff)
```

## Code Style Guidelines

### Python

- Use **88 character line length** for code
- Use **120 character line length** for docstrings and comments
- Use **double quotes** for strings
- Use **4 spaces** for indentation (no tabs)
- Use **type hints** for function signatures
- Use **docstrings** for modules, classes, and complex functions

### Django Templates

- Use **4 spaces** for indentation
- Use **consistent tag spacing**
- Close all tags properly
- Use template inheritance

## Workflow

1. **Make code changes**
2. **Run pre-commit**: `pre-commit run --show-diff-on-failure --color=always --all-files`
3. **Fix any issues** reported
4. **Run tests**: `uv run pytest`
5. **Commit changes**
6. **Repeat** as needed

## Continuous Integration

The project uses pre-commit.ci to automatically run hooks on pull requests. The CI will:

- Run all pre-commit hooks
- Auto-update hooks weekly
- Comment on PRs with issues
- Automatically fix issues when possible

## Tips

1. **Run pre-commit often**: Don't wait until the end to run checks
2. **Fix issues incrementally**: Address issues as they come up
3. **Read error messages**: They usually explain what's wrong
4. **Use auto-fix**: Let the tools fix what they can
5. **Ask for help**: If stuck, ask for clarification

## Configuration Files

- `.pre-commit-config.yaml`: Pre-commit hook configuration
- `pyproject.toml`: Python project configuration (includes ruff, mypy settings)
- `.editorconfig`: Editor configuration for consistent formatting

## References

- [Pre-commit documentation](https://pre-commit.com/)
- [Ruff documentation](https://docs.astral.sh/ruff/)
- [mypy documentation](https://mypy.readthedocs.io/)
- [djLint documentation](https://www.djlint.com/)
