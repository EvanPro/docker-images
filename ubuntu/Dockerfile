FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
        inetutils-ping \
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
    && wget -qO- https://github.com/novnc/noVNC/archive/v1.1.0.tar.gz | tar xz --strip 1 -C /opt/noVNC \
    && wget -qO- https://github.com/novnc/websockify/archive/v0.9.0.tar.gz | tar xz --strip 1 -C /opt/noVNC/utils/websockify \
    && wget -qO- https://dl.bintray.com/tigervnc/stable/tigervnc-1.9.0.x86_64.tar.gz | tar xz --strip 1 -C
    
### RUN vncserver :1
### RUN ./launch.sh --vnc localhost:5901
CMD ["/bin/bash"]
