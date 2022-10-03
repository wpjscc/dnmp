server {

    listen *:80;
    server_name ${domain};

    root /www/${domain}/public;
    index index.php index.html index.htm;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        try_files $uri /index.php =404;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass   php:9000;
	    fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
	    fastcgi_read_timeout 600;
    }

    #location ~ /.well-known {
     #   allow all;
    #}

    location /.well-known/acme-challenge/ {
        default_type "text/plain";
        alias /var/www/certbot/${domain}/;
    }

    access_log /var/log/nginx/${domain}.access.log;
    error_log  /var/log/nginx/${domain}.error.log;
    client_max_body_size 200M;

    listen 443 ssl;
    #配置HTTPS的默认访问端口为443。
    #如果未在此处配置HTTPS的默认访问端口，可能会造成Nginx无法启动。
    #如果您使用Nginx 1.15.0及以上版本，请使用listen 443 ssl代替listen 443和ssl on。
    ssl_certificate /etc/nginx/conf.d/ssl/dummy/${domain}/fullchain.pem;  #需要将cert-file-name.pem替换成已上传的证书文件的名称。
    ssl_certificate_key /etc/nginx/conf.d/ssl/dummy/${domain}/privkey.pem; #需要将cert-file-name.key替换成已上传的证书私钥文件的名称。
    ssl_session_timeout 5m;
    ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:ECDHE:ECDH:AES:HIGH:!NULL:!aNULL:!MD5:!ADH:!RC4;
    #表示使用的加密套件的类型。
    ssl_protocols TLSv1.1 TLSv1.2 TLSv1.3; #表示使用的TLS协议的类型。
    ssl_prefer_server_ciphers on;
    if ($scheme != "https") {
       # return 301 https://$host$request_uri;
    }

}