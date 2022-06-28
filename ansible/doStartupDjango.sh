#!/bin/bash

sudo supervisorctl start guni:gunicorn
#python3 manage.py runserver