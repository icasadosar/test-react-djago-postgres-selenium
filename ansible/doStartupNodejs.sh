#!/bin/bash

cd /{{ path }}/{{ project }}/{{ app }}
sudo supervisorctl start gnpm:npm
#npm start