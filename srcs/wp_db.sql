CREATE DATABASE wordpress;
CREATE USER 'username'@'localhost' IDENTIFIED BY 'username';
GRANT ALL PRIVILEGES ON wordpress.* TO 'username'@'localhost'
	IDENTIFIED BY 'password';
FLUSH PRIVILEGES;