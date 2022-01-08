server {
    server_name stabrabbits.com www.stabrabbits.com;

    location = /favicon.ico { access_log off; log_not_found off; }
    location /static/ {
        root /home/tharnid/stabrabbits/stabrabbits;
    }

    location / {
	include proxy_params;
	proxy_pass http://unix:/run/gunicorn.sock;
    }	

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/stabrabbits.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/stabrabbits.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot


}
server {
    if ($host = www.stabrabbits.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    if ($host = stabrabbits.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen 80;
    server_name stabrabbits.com www.stabrabbits.com;
    return 404; # managed by Certbot




}