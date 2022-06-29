#!/bin/bash

sudo service supervisord restart
cd /{{ path }}/{{ project }}/{{ app }}
sudo supervisorctl start guni:gunicorn
#python3 manage.py runserver