FROM debian:bookworm-slim

RUN groupadd --gid 1000 vscode \
  && useradd --uid 1000 --gid vscode --shell /bin/bash --create-home vscode

ARG TZ
ENV TZ="$TZ"

# Install basic development tools and iptables/ipset
RUN apt-get update && apt-get install -y --no-install-recommends \
  less \
  curl \
  ca-certificates \
  git \
  sudo \
  unzip \
  gnupg2 \
  gh \
  iptables \
  ipset \
  iproute2 \
  dnsutils \
  aggregate \
  jq \
  nano \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# Ensure default vscode user has access to /usr/local/share
RUN chown -R vscode:vscode /usr/local/share

ARG USERNAME=vscode

# Persist bash history.
RUN SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.bash_history" \
  && mkdir /commandhistory \
  && touch /commandhistory/.bash_history \
  && chown -R $USERNAME /commandhistory

# Set `DEVCONTAINER` environment variable to help with orientation
ENV DEVCONTAINER=true

# Create workspace and config directories and set permissions
RUN mkdir -p /workspace /home/vscode/.claude && \
  chown -R vscode:vscode /workspace /home/vscode/.claude

WORKDIR /workspace

# Set up non-root user
USER vscode

# Add Claude Code to PATH
ENV PATH=$PATH:/home/vscode/.local/bin

# Set the default shell to bash rather than sh
ENV SHELL=/bin/bash

# Set the default editor and visual
ENV EDITOR=nano
ENV VISUAL=nano

# Install Claude Code using native installer
RUN curl -fsSL https://claude.ai/install.sh | bash

# Copy and set up firewall script
COPY init-firewall.sh /usr/local/bin/
USER root
RUN chmod +x /usr/local/bin/init-firewall.sh && \
  echo "vscode ALL=(root) NOPASSWD: /usr/local/bin/init-firewall.sh" > /etc/sudoers.d/vscode-firewall && \
  chmod 0440 /etc/sudoers.d/vscode-firewall
USER vscode