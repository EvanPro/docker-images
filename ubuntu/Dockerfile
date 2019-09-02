FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
        inetutils-ping \
        lsb-release \
        net-tools \
        sudo \
        unzip \
        vim \
        zip \
        wget \
        supervisor \
        xfce4 \
        xfce4-terminal \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/* \
    && wget -P /opt/ https://github.com/novnc/noVNC/archive/v1.1.0.tar.gz \
    && tar -xf /opt/v1.1.0.tar.gz -C /opt
    && wget -P /opt/ https://github.com/novnc/websockify/archive/v0.9.0.tar.gz \
    && tar -xf /opt/v0.9.0.tar.gz -C /opt/noVNC-1.1.0/utils /
    && wget -qO- https://dl.bintray.com/tigervnc/stable/tigervnc-1.9.0.x86_64.tar.gz | tar xz --strip 1 -C
CMD ["/bin/bash"]
