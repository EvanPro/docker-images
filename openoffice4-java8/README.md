# 此镜像基于
- openoffice 4.1.7
- open-jdk 1.8.0

openoffice 安装目录：
`/opt/openoffice4`

# 如需启动openoffice：
- 临时启动： 临时启动之后画面就不会动了, 不要认为是死机。只要不报错就是好现象。
```shell
/opt/openoffice4/program/soffice "-accept=socket,host=0.0.0.0,port=8100;urp;StarOffice.ServiceManager" -nologo -headless -nofirststartwizard
```
- 永久启动：
```shell
nohup /opt/openoffice4/program/soffice -headless -accept="socket,host=127.0.0.1,port=8100;urp;" -nofirststartwizard &
```


# 使用方法：
将要部署的可执行jar命名为`app.jar`，并将其所在目录映射至容器的`/app`下即可。

eg：docker run -d -v /root/app:/app fsp

日志文件已重定向至`/log/app.log`

[OpenOffice安装部分参考此链接](https://github.com/xiaojun207/openoffice4-daemon)
