#!/bin/bash

sudo supervisord restart
cd /{{ path }}/{{ project }}/{{ app }}
sudo supervisorctl start gnpm:npm
#npm start