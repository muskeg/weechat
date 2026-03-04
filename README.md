# WeeChat Docker

A Docker image that builds [WeeChat](https://weechat.org/) from source and runs it inside a `screen` terminal session.

## Quick Start

```bash
# Build the image
docker build -t weechat .

# Run WeeChat
docker run -it --name weechat weechat
```

## Usage

### Build Options

The default WeeChat version is **4.4.3**. Override it at build time:

```bash
docker build -t weechat --build-arg WEECHAT_VERSION=4.3.0 .
```

### Running

```bash
# Start a new container
docker run -it --name weechat weechat

# Detach from screen without stopping WeeChat: Ctrl-a d

# Reattach to the running session
docker exec -it weechat screen -r weechat
```

### Persisting Configuration

Mount a host directory to keep your WeeChat config across container removals:

```bash
docker run -it --name weechat \
  -v ~/weechat-config:/home/weechat/.config/weechat \
  weechat
```

## Enabling Script Language Plugins

Python, Perl, Ruby, Lua, and other scripting languages are disabled by default to keep the image small. To enable them:

1. Flip the corresponding `-DENABLE_<LANG>=ON` flag in the `Dockerfile` builder stage.
2. Add the matching runtime library (e.g. `libpython3-dev`) to the runtime stage's `apt-get install`.
3. Rebuild the image.

## Files

| File | Description |
|---|---|
| `Dockerfile` | Multi-stage build — compiles WeeChat from source, then copies binaries into a slim runtime image with `screen`. |
| `entrypoint.sh` | Launches WeeChat inside a named `screen` session for easy detach/reattach. |
| `.dockerignore` | Keeps the build context small. |

## License

WeeChat is licensed under the [GPL-3.0](https://www.gnu.org/licenses/gpl-3.0.html).
