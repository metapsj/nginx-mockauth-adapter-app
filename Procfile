# dnsmasq: dnsmasq
nginx: nginx -p $(pwd) -c config/nginx.conf
auth: rackup -p 5000 -o 127.0.0.1 ../nginx-mockauth-adapter-app/config.ru
hello: rackup -p 5100 -o 127.0.0.1 ../hello-app/config.ru
