FROM    debian:buster

#i install all that i need 
RUN     apt-get -y update \
        && apt-get -y upgrade \
        && apt-get install -y  \
        systemd \
        nginx \
        openssl \
        vim

# i expose this port because this is where i will mapped 
EXPOSE  443

# i copy the config of nginx in the repos default
COPY    ./config/nginx.conf /etc/nginx/sites-available/default

# i delete the original config file of nginx because i have my own config file
RUN     rm -rf /etc/nginx/sites-enabled/default

# i creat an alias from sites-enabled/default to sites-available default, it mean if
# we execute the file config in sites-enabled it will execute the file config in sites-available/default
RUN     ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

RUN     mkdir -p /etc/nginx/ssl

RUN     openssl req -newkey rsa:2048 -x509 -days 365 -nodes -keyout /etc/nginx/ssl/services.key -out /etc/nginx/ssl/services.pem \
        -subj "/C=FR/ST=Paris/L=Paris/O=42, Inc./OU=IT/CN=Inception"


CMD     ["nginx", "-g", "daemon off;"]
