FROM ubuntu:16.04 AS ubuntu-base

# 设置阿里云源，并设置语言、时区，安装基本工具
# RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
#     && apt-get update \
RUN apt-get update \
    && apt-get install -y --no-install-recommends locales language-pack-zh-hans tzdata wget sudo net-tools inetutils-ping vim\
    && locale-gen zh_CN.UTF-8 \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/*

ENV LANG zh_CN.UTF-8
ENV LANGUAGE zh_CN:zh
ENV LC_ALL zh_CN.UTF-8
ENV TZ='Asia/Shanghai'

FROM ubuntu-base AS ubuntu1604-xfce

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get clean \
    && apt-get update \
    && apt-get install -y supervisor xfce4 xfce4-terminal language-pack-zh-hans language-pack-zh-hans-base \
    && apt-get purge -y pm-utils xscreensaver* \
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

WORKDIR /root
COPY [ "./src/", "dockerstartup/" ]
RUN chmod +x dockerstartup/*.sh
ENTRYPOINT ["dockerstartup/start_up.sh"]
CMD ["/bin/bash"]
