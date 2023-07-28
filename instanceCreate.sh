#!/bin/bash 

set -ex

sudo apt-get update
sudo apt-get install nginx

sudo systemctl enable nginx

sudo systemctl is-enabled nginx

sudo mkdir -p /var/www/firstSite/html

echo "<!DOCTYPE html>
<html lang='en'>
<head>
    <title>Main</title>
    <meta charset='utf-8'>
</head>
<body>
    <h1>Hello, World</h1>
</body>
</html>" | sudo tee /var/www/firstSite/html/index.html

echo "server {
    listen 888;
    listen [::]:888;

    root /var/www/firstSite/html;
    index index.html;
}" | sudo tee /etc/nginx/sites-available/firstSite.conf 


sudo ln -s /etc/nginx/sites-available/firstSite.conf /etc/nginx/sites-enabled/

sudo nginx -t

sudo rm /etc/nginx/sites-enabled/default

sudo systemctl restart nginx


