FROM node:lts-trixie

RUN apt-get update && apt-get install -y \
    bash \
    git \
    ripgrep \
    fd-find \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Debian calls the executable fdfind; Pi expects fd.
RUN ln -s "$(command -v fdfind)" /usr/local/bin/fd

RUN npm install -g @earendil-works/pi-coding-agent

RUN useradd -m -s /bin/bash pi

USER pi
WORKDIR /home/pi

RUN mkdir -p /home/pi/.pi/agent
COPY rechenknecht-models.json /home/pi/.pi/agent/models.json

ENV PATH="/usr/local/bin:/usr/bin:/bin"
