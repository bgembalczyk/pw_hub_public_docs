export COMPOSE_FILE := "docker-compose.local.yml"
# 🧾 Justfile for local Django + Docker development
# Type `just` to see available commands

# === Variables ===
compose := "docker compose -f docker-compose.local.yml"
django := "docker compose -f docker-compose.local.yml run --rm django"

# === Default: show all available commands ===
default:
    @echo ""
    @echo "🚀  Available commands for the pw_hub project:"
    @echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    @just --list --unsorted
    @echo "💡  Tip: You can run any command with 'just <task>'"
    @echo ""

# === 🐋 Docker lifecycle ===

# Build docker containers
build *args:
    {{compose}} build {{args}}

# Start local docker environment
up:
    {{compose}} up -d

# Stops and removes docker containers
down:
    {{compose}} down

# Show logs for the Django container
logs:
    {{compose}} logs django

# Remove the database volumes
[confirm("Are you sure you want to remove all the databases?")]
clean-volumes: down
    docker volume remove pw_hub_pw_hub_local_postgres || true
    echo "🧹 Removed pw_hub docker volumes"

# === 🧹 Development ===

# Runs mypy type checker
mypy *args:
    {{django}} mypy pw_hub {{args}}

alias mp := mypy

# Runs pytest tests
pytest:
    {{django}} pytest

alias p := pytest

# Runs behave tests
behave *args:
    {{django}} python manage.py behave --no-input {{args}}

alias b := behave


# manage.py makemigrations
makemigrations *args:
    {{django}} python manage.py makemigrations {{args}}

alias mm := makemigrations

# manage.py showmigrations
showmigrations *args:
    {{django}} python manage.py showmigrations {{args}}

alias sm := showmigrations

# manage.py migrate
migrate *args:
    {{django}} python manage.py migrate {{args}}

alias m := migrate

# manage.py load_all_fixtures - loads all fixtures that names end with _data.json
load_all_fixtures:
    {{django}} python manage.py load_all_fixtures

# Reset db, migrate and load fixtures
reload_db:
    {{django}} python manage.py reset_db --no-input
    {{django}} python manage.py migrate
    {{django}} python manage.py load_all_fixtures

# Runs the python shell in the django environment
shell *args:
    {{django}} python manage.py shell {{args}}

# Runs pytest and behave tests creating a test coverage report
coverage:
    container_name=$({{compose}} ps -q django);
    {{django}} coverage run -m pytest && \
    {{django}} coverage run -a manage.py behave --no-input && \
    {{django}} coverage report -m && \
    {{django}} coverage xml -o coverage.xml && \
    docker cp "$container_name:/app/coverage.xml" ./coverage.xml && \
    echo "✅ coverage.xml copied to host"

alias c := coverage

# === ⚙️ Django Management ===

# Runs python manage.py commands, e.g: just manage createapp
manage *args:
    {{django}} python manage.py {{args}}


# === 🧩 Code quality ===
# Runs the pre-commiter. If it failed - try to utilize `fix-safe-dir`
@precommit:
    echo -e "\e[1mdocker compose -f docker-compose.local.yml exec django pre-commit run --show-diff-on-failure --color=always --all-files\e[0m"
    if docker compose -f docker-compose.local.yml exec django pre-commit run --show-diff-on-failure --color=always --all-files; then \
        echo "✅ Pre-commit passed!"; \
    else \
        echo "💡  If pre-commit failed with 'FatalError: git failed. Is it installed, and are you in a Git repository directory?'"; \
        echo "🛠️  Use \`just fix-safe-dir\` to fix the issue."; \
        exit 1; \
    fi

alias pre := precommit

# Fixes the 'FatalError: git failed. Is it installed, and are you in a Git repository directory?' when using pre-commit
fix-safe-dir:
    {{compose}} exec django git config --global --add safe.directory /app

# Runs the bash terminal inside the django container
bash *args:
    {{django}} bash {{args}}
