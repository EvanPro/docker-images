FROM centos:7

ARG OO_VERSION=4.1.7
ARG OO_TGZ_URL="https://jaist.dl.sourceforge.net/project/openofficeorg.mirror/${OO_VERSION}/binaries/zh-CN/Apache_OpenOffice_${OO_VERSION}_Linux_x86-64_install-rpm_zh-CN.tar.gz"

### support chinese
COPY fonts/ /usr/share/fonts/

## RUN yum -y groupinstall chinese-support
RUN yum -y install mkfontscale mkfontdir fontconfig

RUN cd /usr/share/fonts/ && \
chmod -R 755 /usr/share/fonts && \
mkfontscale && \
mkfontdir && \
fc-cache -fv

RUN yum install -y java-1.8.0-openjdk.x86_64
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.252.b09-2.el7_8.x86_64/

#RUN tar -zxf /tmp/*.tar.gz -C /tmp && \
RUN (curl -0 $OO_TGZ_URL | tar -zx -C /tmp) && \
    yum localinstall -y /tmp/*/RPMS/*.rpm && \
    yum install -y make && \
    yum clean all -y && \
    rm -rf /tmp/*.tar.gz /tmp/*

# 部署jar包
VOLUME /tmp

RUN mkdir app

RUN bash -c "touch /app/app.jar"

ENTRYPOINT ["java", "-Xms4g", "-Xmx4g", "-Dfile.encoding=utf-8", "-jar", "/app/app.jar", "> /log/app.log"]