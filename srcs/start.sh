# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    start.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: weambros <weambros@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/26 14:50:41 by weambros          #+#    #+#              #
#    Updated: 2020/12/29 14:56:43 by weambros         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

service mysql start
service php8.0-fpm start
service nginx start
bash