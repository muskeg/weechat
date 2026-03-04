# WeeChat Docker

A Docker image that builds [WeeChat](https://weechat.org/) from source. Designed to run on a remote server — the container keeps WeeChat running in the background even after you close your SSH session.

## Quick Start

```bash
# Build and start WeeChat in the background
docker compose up -d

# Connect to WeeChat
docker exec -it weechat screen -r weechat

# Detach without stopping: Ctrl-a d
```

## Usage

### Build Options

By default the image automatically fetches the **latest WeeChat release** from GitHub. To pin a specific version, edit the `curl`/`jq` line in the Dockerfile or build from a tagged source tarball.

### Running

```bash
# Start WeeChat (builds the image automatically on first run)
docker compose up -d

# Connect to WeeChat
docker exec -it weechat screen -r weechat

# Detach without stopping WeeChat (keeps running after SSH disconnect)
# Press: Ctrl-a d

# Reconnect later (e.g. new SSH session)
docker exec -it weechat screen -r weechat

# Stop WeeChat
docker compose stop

# Start it again
docker compose start
```

### Upgrading

Your configuration, logs, and data are stored in named Docker volumes and
survive container rebuilds:

```bash
# Rebuild with the latest WeeChat release — all your data is preserved
docker compose up -d --build
```

### Persisting Configuration

All WeeChat data is stored in the `data/` folder in the project directory and
mounted into the container:

| Host Path | Container Path | Contents |
|---|---|---|
| `data/config/` | `~/.config/weechat/` | Settings |
| `data/share/` | `~/.local/share/weechat/` | Scripts, plugins data, logs |

The cache directory (`~/.cache/weechat/`) is kept inside the container since it
holds runtime files (FIFO pipes) that require a native filesystem.

You can browse and edit these files directly from the host. Logs are in `data/share/logs/`.

## Enabling Script Language Plugins

Python, Perl, Ruby, Lua, and other scripting languages are disabled by default to keep the image small. To enable them:

1. Uncomment the matching build **and** runtime dependencies in the `Dockerfile` (they're labelled).
2. Flip the corresponding `-DENABLE_<LANG>=ON` in the `cmake` command.
3. Rebuild: `docker compose up -d --build`.

## WeeChat Quick Reference

All commands below are typed inside WeeChat (press the line at the bottom).

### Adding an IRC Server

```
/server add libera irc.libera.chat/6697 -ssl
/set irc.server.libera.nicks "mynick"
/set irc.server.libera.username "myuser"
/set irc.server.libera.realname "My Name"
/connect libera
```

### Auto-Connect on Startup

```
/set irc.server.libera.autoconnect on
```

To auto-join channels when connecting:

```
/set irc.server.libera.autojoin "#channel1,#channel2"
```

### SASL Authentication (NickServ)

```
/set irc.server.libera.sasl_mechanism plain
/set irc.server.libera.sasl_username "mynick"
/set irc.server.libera.sasl_password "mypassword"
```

### Timezone

WeeChat inherits the container's timezone (UTC by default). To change it, create a local override file that won't be overwritten by `git pull`:

```bash
cp docker-compose.override.example.yml docker-compose.override.yml
```

Then edit `docker-compose.override.yml` with your timezone:

```yaml
services:
  weechat:
    environment:
      - TZ=America/New_York
```

Docker Compose merges this file automatically. The override is gitignored so it survives pulls.

Or set the timestamp format inside WeeChat:

```
/set weechat.look.buffer_time_format "%H:%M:%S"
```

### Logging

Enable logging for all buffers:

```
/set logger.level.irc 4
/set logger.file.auto_log on
/set logger.file.path "%h/logs/"
/set logger.file.mask "$plugin.$name/%Y-%m-%d.log"
```

Logs are stored in the `weechat-logs` volume and persist across upgrades.

View or change log settings:

```
/logger list
/set logger.*
```

### Scripts

> **Note:** Script plugins (Python, Perl, etc.) must be enabled in the Dockerfile first — see [Enabling Script Language Plugins](#enabling-script-language-plugins).

#### Install scripts from the official repository

```
/script install go.py         # quick buffer switching
/script install buffers.pl    # buffer list sidebar
/script install autosort.py   # auto-sort buffers
```

#### List / search scripts

```
/script list
/script search <keyword>
```

#### Load a custom script manually

Place it in `~/.local/share/weechat/python/` (or `perl/`, `ruby/`, etc.), then:

```
/python load my_script.py
```

To auto-load on startup, symlink it into the `autoload/` subdirectory:

```
/python autoload my_script.py
```

### Other Useful Commands

```
/help                        # full command list
/set *keyword*               # search all settings
/fset                        # interactive settings browser
/join #channel               # join a channel
/part                        # leave the current channel
/nick newnick                # change your nick
/save                        # save all config files now
/quit                        # exit WeeChat
```

## Files

| File | Description |
|---|---|
| `Dockerfile` | Multi-stage build — compiles WeeChat from source, then copies binaries into a slim runtime image. |
| `docker-compose.yml` | Defines the service with named volumes for persistent data. |
| `entrypoint.sh` | Runs WeeChat as the container's main process. |
| `.dockerignore` | Keeps the build context small. |

## License

WeeChat is licensed under the [GPL-3.0](https://www.gnu.org/licenses/gpl-3.0.html).
