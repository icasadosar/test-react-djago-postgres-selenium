#!/bin/bash

sudo service supervisord restart
cd /{{ path }}/{{ project }}/{{ app }}
sudo supervisorctl start gnpm:npm
#npm start