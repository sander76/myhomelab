# AGENTS.md - AI Coding Agent Guidelines

This document provides guidelines for AI coding agents working in this repository.

## Repository Overview

This is a **Docker Compose homelab infrastructure** repository. It contains no application
code—only YAML configuration files for self-hosted services running via Docker Compose.

### Directory Structure

```
/
├── docker-compose.yaml     # Main entry point (includes service compose files)
├── compose/                # Service definitions (one directory per service)
│   └── <service>/
│       └── compose.yml     # Service-specific Docker Compose configuration
├── data/                   # Persistent data volumes (gitignored)
│   └── <service>/
│       └── .gitkeep        # Preserves directory structure in git
├── .env                    # Environment variables for Docker Compose
├── README.md               # Setup documentation
└── AGENTS.md               # This file
```

## Commands

### Docker Compose Operations

```bash
docker compose up -d              # Start all services in detached mode
docker compose down               # Stop and remove all containers
docker compose restart            # Restart all services
docker compose ps                 # View running containers
docker compose logs -f            # Follow logs from all services
docker compose logs -f <service>  # Follow logs from specific service
docker compose pull               # Pull latest images
docker compose up -d --pull always # Recreate with new images
docker compose up -d <service>    # Start specific service only
docker compose stop <service>     # Stop specific service
```

### Validation

```bash
docker compose config             # Validate Docker Compose configuration
docker compose config -q          # Check config with quiet output (errors only)
```

## Adding a New Service

1. **Create service directory:** `mkdir -p compose/<service-name>`
2. **Create compose.yml file:** `touch compose/<service-name>/compose.yml`
3. **Create data directory:** `mkdir -p data/<service-name> && touch data/<service-name>/.gitkeep`
4. **Include in main docker-compose.yaml:**
   ```yaml
   include:
     - compose/<service-name>/compose.yml
   ```
5. **Add secrets (if needed):** Store in `${SECRETS}/` directory and reference via `secrets:` directive

## Code Style Guidelines

### YAML Formatting

- **Indentation:** 2 spaces (no tabs)
- **Strings:** Use single quotes for string values: `TZ: 'Europe/Amsterdam'`
- **Comments:** Add comments to explain non-obvious configuration
- **File naming:** Use `compose.yml` for service files (not `docker-compose.yml`)

### Example Service Configuration

```yaml
# Brief description with link to documentation
services:
  myservice:
    container_name: myservice
    image: author/image:latest
    secrets:
      - myservice_secret
    ports:
      # Description of port mapping
      - '8080:80/tcp'
    environment:
      TZ: 'Europe/Amsterdam'
      CONFIG_VAR: 'value'
    volumes:
      # Description of volume purpose
      - ${MYHOMELAB}/data/myservice:/app/data
    restart: unless-stopped

secrets:
  myservice_secret:
    file: ${SECRETS}/myservice.txt
```

### Environment Variables

- Use UPPERCASE with underscores: `MYHOMELAB`, `SECRETS`
- No quotes around values in `.env` files
- Reference in compose files with `${VAR_NAME}` syntax

### Secrets Management

- **Never commit secrets** to the repository
- Store secrets in external directory referenced by `${SECRETS}`
- Use Docker Compose `secrets:` feature to mount secrets
- Name secret files descriptively: `<service-name>.txt` or `<service-name>-<purpose>.txt`

## Git Conventions

### Commit Messages

- Lowercase, no period at end
- Short and descriptive (under 50 characters)
- Use imperative mood: "add", "fix", "change", "update", "remove"

**Examples:**
```
add nginx reverse proxy service
fix pihole admin port mapping
update traefik to v3
remove deprecated config option
```

### What to Commit

- Docker Compose configuration files
- Documentation updates
- `.gitkeep` files for data directories

### What NOT to Commit

- Data directories (gitignored via `data/`)
- Secret files
- Environment-specific overrides
- Container logs or temporary files

## Common Patterns

- **Port mapping:** Use explicit protocol (`'8080:80/tcp'`), document purpose with comments
- **Volumes:** Use `${MYHOMELAB}/data/<service>`, add comments, create `.gitkeep`
- **Container naming:** Use `container_name: <service>`, lowercase with hyphens if needed
- **Restart policy:** Default to `restart: unless-stopped`, use `always` for critical services

## Troubleshooting

```bash
docker compose ps -a              # Check container status and health
docker stats                      # View container resource usage
docker compose exec <service> /bin/sh  # Execute shell in running container
docker compose config --services  # View container configuration
docker compose up -d --force-recreate <service>  # Force recreate a service
```
