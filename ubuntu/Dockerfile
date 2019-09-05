FROM ubuntu:16.04 AS ubuntu1604

ENV DEBIAN_FRONTEND=noninteractive \
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
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/* \
    && localedef -i zh_CN -c -f UTF-8 -A /usr/share/locale/locale.alias zh_CN.UTF-8
    
ENV LANG zh_CN.UTF-8 \
    LC_ALL='zh_CN.UTF-8' \
    LANGUAGE='zh_CN:zh'
    
FROM ubuntu1604 AS ubuntu1604-xfce-vnc

RUN sed -i s@/archive.ubuntu.com/@/mirrors.tuna.tsinghua.edu.cn/@g /etc/apt/sources.list \
    && apt-get clean \
    && apt-get update \
    && apt-get install -y \
    supervisor \
    xfce4 \
    xfce4-terminal \
    && apt-get purge -y \
    pm-utils \
    xscreensaver* \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/*

ENV DISPLAY=:1 \
    VNC_PW=vncpassword \
    NO_VNC_PORT=6901 \
    NO_VNC_HOME=/opt/noVNC

RUN mkdir /opt/noVNC \
    && wget -qO- https://github.com/novnc/noVNC/archive/v1.1.0.tar.gz | tar xz --strip 1 -C $NO_VNC_HOME \
    && mkdir /opt/noVNC/utils/websockify \
    && wget -qO- https://github.com/novnc/websockify/archive/v0.9.0.tar.gz | tar xz --strip 1 -C $NO_VNC_HOME/utils/websockify \
    && chmod +x -v $NO_VNC_HOME/utils/*.sh \
    && mkdir /opt/tigervnc \
    && wget -qO- https://dl.bintray.com/tigervnc/stable/tigervnc-1.9.0.x86_64.tar.gz | tar xz --strip 1 -C /

WORKDIR ~
COPY [ "./src/", "dockerstartup/" ]
RUN chmod +x dockerstartup/*.sh
ENTRYPOINT ["dockerstartup/start_up.sh"]
CMD ["/bin/bash"]
