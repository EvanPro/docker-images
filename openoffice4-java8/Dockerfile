FROM openjdk:8-jdk

ARG OO_VERSION=4.1.9
ARG OO_TGZ_URL="https://jaist.dl.sourceforge.net/project/openofficeorg.mirror/${OO_VERSION}/binaries/zh-CN/Apache_OpenOffice_${OO_VERSION}_Linux_x86-64_install-deb_zh-CN.tar.gz"
### support chinese
COPY fonts/ /usr/share/fonts/

RUN apt-get update && apt-get install -y xfonts-utils

RUN cd /usr/share/fonts/ && \
    chmod -R 777 /usr/share/fonts && \
    mkfontscale && \
    mkfontdir && \
    fc-cache -fv

RUN (curl -0 $OO_TGZ_URL | tar -zx -C /tmp) && \
    dpkg -i /tmp/*/DEBS/*.deb && \
    rm -rf /tmp/*.tar.gz /tmp/*

# 部署jar包
VOLUME /tmp

RUN mkdir app

RUN bash -c "touch /app/app.jar"

ENTRYPOINT ["java", "-jar", "/app/app.jar", "> /log/app.log"]
