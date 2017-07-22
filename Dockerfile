# 设置继承自己创建的 sshd 镜像
FROM ubuntu-sshd

# 维护者
LABEL maintainer="CaseyCui cuikaidong@foxmail.com"

# 安装 nginx, 设置 nginx 以非 daemon 启动
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
        nginx \
        geoip-bin \
        fcgiwrap \
        ssl-cert \
    && rm -rf /var/lib/apt/lists/* \
    && echo -e "\ndaemon off;" >> /etc/nginx/nginx.conf \
    && chown -R www-data:www-data /var/lib/nginx

# 添加脚本，并设置权限
COPY run-nginx.sh /run-nginx.sh
#RUN chmod 755 /run-nginx.sh

# 定义工作目录
WORKDIR /etc/nginx

# 添加挂载点 /var/www
VOLUME /var/www

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
        && ln -sf /dev/stderr /var/log/nginx/error.log

# 定义输出端口
EXPOSE 80
EXPOSE 443

# 定义输出命令
CMD ["/run-nginx.sh"]
