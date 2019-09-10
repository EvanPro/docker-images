FROM ubuntu:16.04 AS ubuntu-base

# 设置阿里云源，并设置语言、时区，安装基本工具
# RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
#     && apt-get update \
RUN apt-get update \
    && apt-get install -y --no-install-recommends locales language-pack-zh-hans tzdata wget sudo net-tools inetutils-ping vim\
    && locale-gen zh_CN.UTF-8 \
    && dpkg-reconfigure locales \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/*

ENV LANG zh_CN.UTF-8
ENV LANGUAGE zh_CN:zh
ENV LC_ALL zh_CN.UTF-8
ENV TZ='Asia/Shanghai'

FROM ubuntu-base AS ubuntu-xfce

#安装xfce

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y xfce4 xfce4-terminal language-pack-zh-hans language-pack-zh-hans-base ttf-wqy-zenhei \
    && apt-get purge -y pm-utils xscreensaver* \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/*

ENV DISPLAY=:1
ENV VNC_PW=vncpassword
RUN mkdir /opt/tigervnc \
    && wget -qO- https://dl.bintray.com/tigervnc/stable/tigervnc-1.9.0.x86_64.tar.gz | tar xz --strip 1 -C /

EXPOSE 5901

FROM ubuntu-xfce AS ubuntu-ssh
# 安装ssh
RUN apt-get update \
    && apt-get install -y supervisor openssh-server \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/*

RUN echo_supervisord_conf > /etc/supervisord.conf
RUN echo "[program:ssh]\ncommand=/usr/sbin/sshd -D\nstdout_events_enabled=true\nstderr_events_enabled=true\nautorestart=true">>/etc/supervisord.conf

RUN RUN mkdir /var/run/sshd

RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN mkdir /root/.ssh

EXPOSE 22

WORKDIR /root
COPY [ "./src/", "dockerstartup/" ]
RUN chmod +x dockerstartup/*.sh

ENTRYPOINT ["dockerstartup/start_up.sh"]
CMD ["/bin/bash"]
