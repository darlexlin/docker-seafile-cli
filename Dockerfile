FROM ghcr.io/linuxserver/baseimage-ubuntu:bionic

# 环境变量
ENV DEBIAN_FRONTEND noninteractive
ENV PUID PGID
ENV TZ Asia/Shanghai

# 安装seafile的cli客户端
RUN	apt update -y && \
		apt install -y wget tzdata && \
		wget https://linux-clients.seafile.com/seafile.asc -O /usr/share/keyrings/seafile-keyring.asc && \
		bash -c "echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/seafile-keyring.asc] https://linux-clients.seafile.com/seafile-deb/bionic/ stable main' > /etc/apt/sources.list.d/seafile.list" && \
		apt update -y && \
		apt install -y seafile-cli && \
		ln -sf /usr/share/zoneinfo/$TZ /etc/localtime && \
		rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
		apt clean

# 初始化
RUN seaf-cli init -d /app -c /app/ccnet

# 数据目录
WORKDIR /sf

# 添加本地文件
COPY root/ /
