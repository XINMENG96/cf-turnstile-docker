# 使用官方 Nginx 镜像作为基础镜像
FROM nginx:latest

# 安装 gettext-base 工具以支持 envsubst 替换
RUN apt-get update && apt-get install -y gettext-base && apt-get clean

# 设置工作目录
WORKDIR /app

# 复制验证脚本和依赖文件
COPY app/validate.py /app/validate.py
COPY app/requirements.txt /app/requirements.txt

# 安装 Python 依赖
RUN pip install --no-cache-dir -r requirements.txt

# 复制配置文件到容器中
COPY config/nginx.conf /etc/nginx/nginx.conf
COPY config/index.html /usr/share/nginx/html/index.html

# 暴露容器的 80 端口
EXPOSE 80

# 启动 Nginx 和验证脚本
CMD /bin/bash -c "envsubst < /etc/nginx/nginx.conf > /etc/nginx/nginx.conf && nginx && python3 /app/validate.py"
