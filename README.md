# Homelab

Personal Docker Compose-based homelab running on Ubuntu.

## Setup

- [Initial server setup with Ubuntu](https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu)
- [Install and use Docker on Ubuntu 22.04](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-22-04)

Create a non-root user, enable SSH, and set up a private/public key:

```bash
ssh-keygen -t rsa -b 4096 -C "s.teunissen@gmail.com"
ssh-copy-id -i ~/.ssh/dietpi dietpi@192.168.188.156
```

Disable password login in `/etc/ssh/sshd_config`:

```
PasswordAuthentication no
```

## Services

Each service has its own Docker Compose file under `compose/<service>/`:

| Service | Compose file |
|---------|-------------|
| Pi-hole | `compose/pi-hole/docker-compose.yaml` |
| Radicale | `compose/radicale/docker-compose.yaml` |
| Immich | `compose/immich/docker-compose.yaml` |
| Linkwarden | `compose/linkwarden/docker-compose.yaml` |
| Shiori | `compose/shiori/docker-compose.yaml` |
| Syncthing | `compose/syncthing/docker-compose.yaml` |
| Wallabag | `compose/wallabag/docker-compose.yaml` |

Start a service:

```bash
cd compose/<service>
docker compose pull
docker compose up -d
docker compose logs -f
```

## Tailscale

Each service (except Pi-hole) runs behind a Tailscale sidecar with automatic HTTPS. Create a Tailscale auth key with a tag, then set it as `TAILSCALE_AUTHKEY` in the environment or `.env` file.

Node keys are stored in the `tailscale/<service>/ts-state/` folder.
