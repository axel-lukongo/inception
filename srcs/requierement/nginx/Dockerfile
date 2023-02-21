from debian:buster

RUN apt-get update && apt-get install nginx -y && apt-get install openssl -y

RUN mkdir -p /etc/nginx/ssl

#j'install openssl il me servira pour mon protocol ssl
RUN openssl req -x509 -nodes \ 
    -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=login.42.fr/UID=login"

RUN mkdir -p /var/run/nginx

#Copy the new configuration inside nginx
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]