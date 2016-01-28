user  www www;
worker_processes  2;

error_log  {PROJECT}/logs/error.log;

pid        {PROJECT}/logs/nginx.pid;

events {
    worker_connections  2048;
}

http {
    include       mime.types;
    default_type  application/octet-stream;


    sendfile        on;

    keepalive_timeout  65;

    # gzip压缩功能设置
    gzip on;
    gzip_min_length 1k;
    gzip_buffers    4 16k;
    gzip_http_version 1.0;
    gzip_comp_level 6;
    gzip_types text/html text/plain text/css text/javascript application/json application/javascript application/x-javascript application/xml;
    gzip_vary on;

    # www.ttjinhuo.com 虚拟主机配置
    server {
        listen       3003;
        server_name  ttjinhuo.com www.ttjinhuo.com;
        root   {PROJECT}/www;

        charset utf-8;
        access_log  {PROJECT}/logs/www.ttjinhuo.com.access.log;

        location / {
            root   {PROJECT}/www;
            index  index.html index.htm;
        }

        location  ~* /download/ {  
            root {PROJECT}/www/download;  
        }
        location ~ .*\.(gif|jpg|jpeg|bmp|png|ico|txt|js|css)$ {   
            root {PROJECT}/www;   
            expires 7d; 
        }
        location ~ ^/(WEB-INF)/ {   
            deny all;   
        }

        # redirect server error pages to the static page /50x.html
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root html;
        }
    }
}
