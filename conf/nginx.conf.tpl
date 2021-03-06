user  www www;
worker_processes  2; #推荐worker数为cpu核数，避免cpu不必要的上下文切换

error_log  {PROJECT}/logs/error.log;

pid        {PROJECT}/logs/nginx.pid;

events {
    #表示每个worker进程所能建立连接的最大值
    #一个nginx最大的连接数max=worker_connections*worker_processes;
    #对于http请求本地资源最大并发数量为max
    #如果http作为反向代理，最大并发数为max/2。因为每个并发会建立与客户端的连接和与后端服务的连接，会占用两个连接
    worker_connections  2048;
}

http {
    include       mime.types;
    default_type  application/octet-stream;
    sendfile        on;
    server_tokens  off; #是否在错误页面和服务器头中输出nginx版本信息
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
        location ~ .*\.(gif|jpg|jpeg|bmp|png|ico|txt|js|css|ttf|otf|woff|svg|mp3|wma|wav|flac|aac|m4a|ogg|avi|mp4|wmv|mkv|mpeg|flv|swf)$ {   
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
