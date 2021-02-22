service mysql start
mysql -u root < /tmp/wp_db.sql
service mysql stop
rm -rf /tmp/wp_db.sql