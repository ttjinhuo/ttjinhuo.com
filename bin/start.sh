#!/bin/bash

PROJECT=$(pwd)
echo ${PROJECT}

# 生成nginx配置文件
cp ${PROJECT}/conf/nginx.conf.tpl ${PROJECT}/conf/nginx.conf.tpl.bak
sed -i "s/{PROJECT}/{$PROJECT}/g"  ${PROJECT}/conf/nginx.conf.tpl
mv ${PROJECT}/conf/nginx.conf.tpl ${PROJECT}/conf/nginx.conf
mv ${PROJECT}/conf/nginx.conf.tpl.bak ${PROJECT}/conf/nginx.conf.tpl

# 启动配置文件
./bin/nginx -c ${PROJECT}/conf/nginx.conf.tpl