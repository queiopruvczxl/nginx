#!/bin/bash
/usr/sbin/sshd -D &
# nginx 以 daemon off 形式启动
/usr/sbin/nginx -g "daemon off;"