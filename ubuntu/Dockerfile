FROM ubuntu:16.04 AS ubuntu-base

# 设置阿里云源，并设置语言、时区，安装基本工具
# RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
#     && apt-get update \
RUN apt-get update \
    && apt-get install -y --no-install-recommends locales tzdata wget sudo net-tools inetutils-ping vim\
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/*

ENV TZ='Asia/Shanghai'

FROM ubuntu-base AS ubuntu-xfce

#安装xfce

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y xfce4 xfce4-terminal \
    && apt-get purge -y pm-utils xscreensaver* \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /opt/tigervnc \
    && wget -qO- https://dl.bintray.com/tigervnc/stable/tigervnc-1.9.0.x86_64.tar.gz | tar xz --strip 1 -C /

EXPOSE 5901

FROM ubuntu-xfce AS ubuntu-ssh
# 安装ssh
RUN apt-get update \
    && apt-get install -y supervisor openssh-server \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /var/run/sshd

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
