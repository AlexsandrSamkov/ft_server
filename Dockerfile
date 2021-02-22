# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: weambros <weambros@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/23 14:24:32 by weambros          #+#    #+#              #
#    Updated: 2020/12/29 15:20:56 by weambros         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt update
RUN apt upgrade -y

#install mysql
RUN apt-get install mariadb-server -y
COPY ./srcs/wp_db.sql ./tmp/wp_db.sql
COPY ./srcs/mysql.sh ./tmp/mysql.sh
RUN bash /tmp/mysql.sh

#install ngix
RUN apt-get install -y nginx
COPY ./srcs/localhost.conf ./etc/nginx/sites-available/localhost.conf
RUN ln -s /etc/nginx/sites-available/localhost.conf /etc/nginx/sites-enabled/localhost.conf
RUN rm -rf /etc/nginx/sites-enabled/default

#instal php
RUN apt -y install lsb-release apt-transport-https ca-certificates wget
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
RUN apt update
RUN apt install php8.0-mysql -y
RUN apt install php8.0-fpm -y

#install php admin
COPY ./srcs/phpMyAdmin-5.0.4-all-languages.tar.gz ./tmp/phpmyadmin.tar.gz
RUN mkdir -p /var/www/localhost/
RUN mkdir -p /var/www/localhost/html
RUN tar xvf /tmp/phpmyadmin.tar.gz -C /tmp/
RUN mv /tmp/phpMyAdmin-5.0.4-all-languages /var/www/localhost/html/phpmyadmin

#install wordpress
COPY ./srcs/wordpress-5.6.tar.gz ./tmp/wp.tar.gz 
RUN tar xvf /tmp/wp.tar.gz -C /var/www/localhost/html

#copy scripts
COPY ./srcs/switch_autoindex.sh ./
COPY ./srcs/start.sh ./

#config access
RUN chown -R www-data /var/www/*
RUN chmod -R 755 /var/www/*

#install ssl
RUN mkdir -p /etc/nginx/certs
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/certs/cert.key -out /etc/nginx/certs/cert.csr -subj '/C=RU/ST=Krasnodrskiy/L=Novorossisk/O=21shcoll/OU=Home/emailAddress=weambros@student.21-school.ru/CN=site'

RUN rm -rf ./tmp/*
EXPOSE 80:80 443:443
CMD bash start.sh