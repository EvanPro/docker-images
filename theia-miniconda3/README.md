此镜像基于theiaide/theia-python:1.13.0  

安装了miniconda3，版本py38_4.9.2  

打开终端时自动激活base enviroment  

# 使用方法
与theia-python一样：
```sh
docker run -it --init -p 3000:3000 -v "$(pwd):/home/project" evan11/theia-miniconda3:py38_4.9.2
```