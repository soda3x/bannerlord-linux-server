FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="$PATH:/usr/share/dotnet"

# Enable 32-bit architecture
RUN dpkg --add-architecture i386

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    apt-transport-https \
    ca-certificates \
    curl \
    tar \
    libgl1-mesa-glx \
    lib32gcc-s1 \
    lib32stdc++6 \
    libcurl4 \
    libssl1.1 \
    gnupg \
    unzip \
    cmake \
    pkg-config \
    g++ \
    mesa-utils \
    libglu1-mesa-dev \
    freeglut3 \
    freeglut3-dev \
    mesa-common-dev \
    libglew-dev \
    libglfw3-dev \
    libglm-dev \
    libao-dev \
    libmpg123-dev && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://packages.microsoft.com/config/debian/11/prod.list && \
    mv prod.list /etc/apt/sources.list.d/microsoft-prod.list && \
    wget https://packages.microsoft.com/keys/microsoft.asc && \
    apt-key add microsoft.asc && \
    apt-get update

# Install .NET SDK
RUN apt-get install -y dotnet-sdk-6.0

RUN useradd -m -d /home/bannerlord -s /bin/bash bannerlord
USER bannerlord
ENV HOME=/home/bannerlord

WORKDIR /home/bannerlord

RUN mkdir -p /home/bannerlord/steamcmd && \
    cd /home/bannerlord/steamcmd && \
    curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -

COPY --chown=bannerlord:bannerlord start.sh /home/bannerlord/start.sh
RUN chmod +x /home/bannerlord/start.sh

CMD ["/home/bannerlord/start.sh"]