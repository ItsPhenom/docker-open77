<p align="center">
  <img height="200" src="https://raw.githubusercontent.com/ItsPhenom/docker-open77/refs/heads/master/.github/assets/banner.png" alt="Open//77 image" />
</p>
<p align="center">
    <a href="https://hub.docker.com/r/itsphenom/open77">
        <img src="https://img.shields.io/docker/stars/itsphenom/open77?&style=flat-square&color=%2300adb0&logo=docker&logoColor=%23ffffff"
            alt="docker stars"></a>
    <a href="https://hub.docker.com/r/itsphenom/open77">
        <img src="https://img.shields.io/docker/pulls/itsphenom/open77?style=flat-square&color=%2300adb0&logo=docker&logoColor=%23ffffff"
            alt="docker pulls"></a>
    <a href="https://hub.docker.com/r/itsphenom/open77">
        <img src="https://img.shields.io/docker/v/itsphenom/open77/latest?style=flat-square&color=%2300adb0&logo=docker&logoColor=%23ffffff"
            alt="docker image version"></a>
    <a href="https://hub.docker.com/r/itsphenom/open77/latest">
        <img src="https://img.shields.io/docker/image-size/itsphenom/open77?style=flat-square&color=%2300adb0&logo=docker&logoColor=%23ffffff"
            alt="docker image size"></a>
    <!-- <a href="https://discord.com/invite/FrAGRsBJDM">
        <img src="https://img.shields.io/discord/1285283319453450261?color=%235865F2&label=discord&logo=discord&logoColor=%23ffffff&style=flat-square"
            alt="chat on Discord"></a> -->
</p>

This Docker image provides a quick and reliable way to run a dedicated [OPEN//77](https://open2077.net) server - a community-built multiplayer platform for Cyberpunk 2077. Spin up your own persistent world for roleplay, racing, freeroam, or a custom game mode you script yourself, all running on your own hardware with your own rules.

The image supports customizable server configuration and persistent storage, so your world, settings, and data survive container restarts and updates.

**Requirements for Clients:** Cyberpunk 2077 2.31+ with Phantom Liberty DLC, and OPEN//77 Alpha access (see [open2077.net](https://open2077.net) for details).

This image is based on [Google's Distroless images](https://github.com/googlecontainertools/distroless) to achieve the lowest possible footprint and reduce attack vectors. The image also gets updated automatically - upstream is checked periodically, and a new build is published as soon as a new version is detected. All published images are cryptographically signed; see [SECURITY.md](./SECURITY.md) for how to verify one.

## Table of Contents
- [Table of Contents](#table-of-contents)
- [Available Tags](#available-tags)
- [How to use this image](#how-to-use-this-image)
  - [... with 'docker run'](#-with-docker-run)
  - [... with 'docker compose'](#-with-docker-compose)
- [Environment Variables](#environment-variables)
- [Useful Links](#useful-links)

## Available Tags

| Tag | Description |
|---|---|
| `latest`, `stable` | Latest **stable** channel release. Recommended for most users. |
| `unstable` | Latest **unstable** channel release. May include newer features or fixes ahead of stable, but is less tested. |
| `<version>` (e.g. `2.31.13-op77.87`) | A specific pinned version, from either channel. Useful for reproducible deployments. |

All tags are rebuilt automatically whenever a new version is published upstream, and are [signed with Cosign](./SECURITY.md#image-signing).

## How to use this image
### ... with 'docker run'
To start a Open//77 server with `docker run`:
```shell
docker run \
  -p 11778:11778/udp \
  -p 11779:11779/tcp \
  -p 11780:11780/tcp \
  -v open77-settings:/app/settings \
  -v open77-resources:/app/resources \
  -v open77-dotfiles:/app/.open77 \
  itsphenom/open77:latest
```

### ... with 'docker compose'
For compose, use this `compose.yml`:
```yaml
services:
  open77:
    image: itsphenom/open77:latest
    restart: unless-stopped
    ports:
      - "11778:11778"
      - "11779:11779"
      - "11780:11780"
    volumes:
      - open77-settings:/app/settings
      - open77-resources:/app/resources
      - open77-dotfiles:/app/.open77

volumes:
  open77-settings:
  open77-resources:
  open77-dotfiles:
```

In both cases the Open//77 server should spin up and present you the first setup instructions. The server.jsonc among other settings files is within the open77-settings volume.

## Environment Variables
Please refer to the [official documentation](https://open2077.net/docs/server-startup#environment-variables) about environment variables. All of them should be able to be passed through Docker to the server.

`docker run` example:
```shell
docker run \
  -p 11778:11778/udp \
  -p 11779:11779/tcp \
  -p 11780:11780/tcp \
  -e OP77_PUBLIC_IP='203.0.113.10' \
  -e OP77_CONFIG__NETWORK__PORT='11778' \
  -e OP77_CONFIG__NETWORK__MAXIMUMPLAYERS='32' \
  -e OP77_CONFIG__RESOURCES__DOWNLOAD__LISTENURL='http://0.0.0.0:11779/' \
  -e OP77_CONFIG__LOGGING__LEVEL='debug' \
  -v open77-settings:/app/settings \
  -v open77-resources:/app/resources \
  -v open77-dotfiles:/app/.open77 \
  itsphenom/open77:latest
```

`compose.yml` example:

```yaml
services:
  open77:
    image: itsphenom/open77:latest
    restart: unless-stopped
    environment:
      OP77_PUBLIC_IP: "203.0.113.10"
      OP77_CONFIG__NETWORK__PORT: "11778"
      OP77_CONFIG__NETWORK__MAXIMUMPLAYERS: "32"
      OP77_CONFIG__RESOURCES__DOWNLOAD__LISTENURL: "http://0.0.0.0:11779/"
      OP77_CONFIG__LOGGING__LEVEL: "debug"
    ports:
      - "11778:11778"
      - "11779:11779"
      - "11780:11780"
    volumes:
      - open77-settings:/app/settings
      - open77-resources:/app/resources
      - open77-dotfiles:/app/.open77

volumes:
  open77-settings:
  open77-resources:
  open77-dotfiles:
```

## Useful Links
* https://open2077.net/docs/host-a-server
* https://open2077.net/docs/server-startup
* https://open2077.net/docs/database

OPEN//77 is an unofficial, independent fan project and is not affiliated with, endorsed by, or sponsored by CD PROJEKT S.A. It is currently in Alpha - expect occasional bugs, crashes, or API changes as the platform evolves.
