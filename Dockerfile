FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Enable 32-bit architecture and install dependencies
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y \
    software-properties-common \
    wget \
    curl \
    xvfb \
    wine64 \
    wine32 \
    steamcmd \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -d /home/bannerlord -s /bin/bash bannerlord
USER bannerlord
ENV HOME=/home/bannerlord
ENV WINEPREFIX=$HOME/.wine
ENV WINEDEBUG=-all

WORKDIR /home/bannerlord

COPY --chown=bannerlord:bannerlord start.sh /home/bannerlord/start.sh
RUN chmod +x /home/bannerlord/start.sh

CMD ["/home/bannerlord/start.sh"]