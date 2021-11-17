sudo journalctl -u gunicorn
sudo systemctl status gunicorn

sudo tail -f /var/log/syslog

## nginx

sudo systemctl restart nginx
sudo nginx -t
sudo journalctl -u nginx
sudo nginx -t && sudo systemctl restart nginx

## Postgres

sudo systemctl status postgresql
sudo systemctl start postgresql
sudo systemctl enable postgresql

#### Postgres command line
\l show dbs
\c <whatever db> / \c stabrabbitsdo

\dt shows tables

sudo -u postgres psql

### Create main project

django-admin startproject <project name>

### Create app inside main project

python3 manage.py <project name>

### Bootstrap

https://www.techwithtim.net/tutorials/django/adding-bootstrap/

### Ubuntu

apt-get update && apt-get upgrade