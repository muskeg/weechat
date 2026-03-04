# Build WeeChat from source and run in a screen session
FROM debian:bookworm-slim AS builder

ARG WEECHAT_VERSION=4.4.3

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    cmake \
    curl \
    gettext \
    libcurl4-gnutls-dev \
    libgcrypt20-dev \
    libgnutls28-dev \
    libncursesw5-dev \
    libzstd-dev \
    pkg-config \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src

RUN curl -fsSL "https://weechat.org/files/src/weechat-${WEECHAT_VERSION}.tar.xz" \
    -o weechat.tar.xz \
    && tar xf weechat.tar.xz \
    && rm weechat.tar.xz

WORKDIR /usr/src/weechat-${WEECHAT_VERSION}

RUN mkdir build && cd build \
    && cmake .. \
        -DCMAKE_INSTALL_PREFIX=/usr/local \
        -DENABLE_PYTHON=OFF \
        -DENABLE_PERL=OFF \
        -DENABLE_RUBY=OFF \
        -DENABLE_LUA=OFF \
        -DENABLE_TCL=OFF \
        -DENABLE_GUILE=OFF \
        -DENABLE_JAVASCRIPT=OFF \
        -DENABLE_PHP=OFF \
        -DENABLE_SPELL=OFF \
        -DENABLE_SCRIPTS=OFF \
        -DENABLE_DOC=OFF \
        -DENABLE_TESTS=OFF \
    && make -j"$(nproc)" \
    && make install

# ── Runtime stage ──
FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    libcurl3-gnutls \
    libgcrypt20 \
    libgnutls30 \
    libncursesw6 \
    libzstd1 \
    screen \
    zlib1g \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/local /usr/local

# Refresh the linker cache so libs in /usr/local/lib are found
RUN ldconfig

# Create a non-root user
RUN useradd -m -s /bin/bash weechat
USER weechat
WORKDIR /home/weechat

# Persist WeeChat config between runs
VOLUME /home/weechat/.config/weechat

# Copy entrypoint
COPY --chown=weechat:weechat entrypoint.sh /home/weechat/entrypoint.sh
RUN chmod +x /home/weechat/entrypoint.sh

ENTRYPOINT ["/home/weechat/entrypoint.sh"]
