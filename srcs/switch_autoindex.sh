# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    switch_autoindex.sh                                :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: weambros <weambros@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/29 14:56:32 by weambros          #+#    #+#              #
#    Updated: 2020/12/29 14:56:34 by weambros         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

if grep -q "autoindex on" /etc/nginx/sites-available/localhost.conf
then
	sed -i "s/autoindex on;/autoindex off;/" /etc/nginx/sites-available/localhost.conf
	echo "autoindex off"
else
	sed -i "s/autoindex off;/autoindex on;/" /etc/nginx/sites-available/localhost.conf
	echo "autoindex on"
fi
service nginx restart;