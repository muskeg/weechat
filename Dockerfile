# Build WeeChat from source and run in a screen session
FROM debian:bookworm-slim AS builder

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    cmake \
    curl \
    gettext \
    jq \
    libcjson-dev \
    libcurl4-gnutls-dev \
    libgcrypt20-dev \
    libgnutls28-dev \
    libncursesw5-dev \
    libzstd-dev \
    pkg-config \
    xz-utils \
    zlib1g-dev \
    # ── Plugin build dependencies ──
    # ENABLE_PYTHON
    python3-dev \
    # ENABLE_PERL
    libperl-dev \
    # ENABLE_SPELL
    libaspell-dev \
    # ENABLE_RUBY  (uncomment to enable)
    # ruby-dev \
    # ENABLE_LUA  (uncomment to enable)
    # liblua5.4-dev \
    # ENABLE_TCL  (uncomment to enable)
    # tcl-dev \
    # ENABLE_GUILE  (uncomment to enable)
    # guile-3.0-dev \
    # ENABLE_PHP  (uncomment to enable)
    # php-dev libphp-embed libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src

# Fetch the latest release tag from GitHub and download the source tarball
RUN WEECHAT_VERSION=$(curl -fsSL https://api.github.com/repos/weechat/weechat/releases/latest | jq -r '.tag_name' | sed 's/^v//') \
    && echo "Building WeeChat ${WEECHAT_VERSION}" \
    && curl -fsSL "https://weechat.org/files/src/weechat-${WEECHAT_VERSION}.tar.xz" \
       -o weechat.tar.xz \
    && tar xf weechat.tar.xz \
    && rm weechat.tar.xz \
    && ln -s weechat-${WEECHAT_VERSION} weechat-src

WORKDIR /usr/src/weechat-src

RUN mkdir build && cd build \
    && cmake .. \
        -DCMAKE_INSTALL_PREFIX=/usr/local \
        -DENABLE_PYTHON=ON \
        -DENABLE_PERL=ON \
        -DENABLE_RUBY=OFF \
        -DENABLE_LUA=OFF \
        -DENABLE_TCL=OFF \
        -DENABLE_GUILE=OFF \
        -DENABLE_JAVASCRIPT=OFF \
        -DENABLE_PHP=OFF \
        -DENABLE_SPELL=ON \
        -DENABLE_SCRIPTS=OFF \
        -DENABLE_DOC=OFF \
        -DENABLE_TESTS=OFF \
    && make -j"$(nproc)" \
    && make install

# ── Runtime stage ──
FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    gosu \
    libcjson1 \
    libcurl3-gnutls \
    libgcrypt20 \
    libgnutls30 \
    libncursesw6 \
    libzstd1 \
    locales \
    screen \
    zlib1g \
    # ── Plugin runtime dependencies ──
    # ENABLE_PYTHON
    libpython3.11 \
    # ENABLE_PERL
    libperl5.36 \
    # ENABLE_SPELL
    aspell aspell-en \
    # ENABLE_RUBY  (uncomment to enable)
    # libruby3.1 \
    # ENABLE_LUA  (uncomment to enable)
    # liblua5.4-0 \
    # ENABLE_TCL  (uncomment to enable)
    # libtcl8.6 \
    # ENABLE_GUILE  (uncomment to enable)
    # guile-3.0-libs \
    # ENABLE_PHP  (uncomment to enable)
    # libphp-embed \
    && rm -rf /var/lib/apt/lists/*

# Generate UTF-8 locale
RUN sed -i '/en_US.UTF-8/s/^# //' /etc/locale.gen && locale-gen
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

COPY --from=builder /usr/local /usr/local

# Refresh the linker cache so libs in /usr/local/lib are found
RUN ldconfig

# Create a non-root user and pre-create WeeChat directories
RUN useradd -m -s /bin/bash weechat \
    && mkdir -p /home/weechat/.config/weechat \
                /home/weechat/.local/share/weechat/logs \
                /home/weechat/.cache/weechat \
    && chown -R weechat:weechat /home/weechat

# Configure screen for UTF-8
RUN echo 'defutf8 on\ndefencoding utf8\ntermcapinfo xterm* ti@:te@' \
    > /home/weechat/.screenrc \
    && chown weechat:weechat /home/weechat/.screenrc

WORKDIR /home/weechat

# Persist WeeChat data between container upgrades
VOLUME /home/weechat/.config/weechat
VOLUME /home/weechat/.local/share/weechat
VOLUME /home/weechat/.cache/weechat

# Copy entrypoint (runs as root, drops to weechat user)
COPY entrypoint.sh /home/weechat/entrypoint.sh
RUN chmod +x /home/weechat/entrypoint.sh

ENTRYPOINT ["/home/weechat/entrypoint.sh"]
