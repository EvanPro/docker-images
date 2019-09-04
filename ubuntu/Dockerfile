FROM ubuntu:16.04

ENV DEBIAN_FRONTEND=noninteractive
    TZ=Asia/Shanghai

RUN sed -i s@/archive.ubuntu.com/@/mirrors.tuna.tsinghua.edu.cn/@g /etc/apt/sources.list \
    && apt-get clean \
    && apt-get update \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && apt-get install -y \
        tzdata \
        inetutils-ping \
        net-tools \
        sudo \
        unzip \
        vim \
        zip \
        wget \
        locales \
        supervisor \
        xfce4 \
        xfce4-terminal \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/* \
    && localedef -i zh_CN -c -f UTF-8 -A /usr/share/locale/locale.alias zh_CN.UTF-8
ENV LANG zh_CN.UTF-8
RUN mkdir /opt/noVNC \
    && wget -qO- https://github.com/novnc/noVNC/archive/v1.1.0.tar.gz | tar xz --strip 1 -C /opt/noVNC \
    && mkdir /opt/noVNC/utils/websockify \
    && wget -qO- https://github.com/novnc/websockify/archive/v0.9.0.tar.gz | tar xz --strip 1 -C /opt/noVNC/utils/websockify \
    && mkdir /opt/tigervnc \
    && wget -qO- https://dl.bintray.com/tigervnc/stable/tigervnc-1.9.0.x86_64.tar.gz | tar xz --strip 1 -C /
    
### RUN vncserver :1
### RUN ./launch.sh --vnc localhost:5901
CMD ["/bin/bash"]
