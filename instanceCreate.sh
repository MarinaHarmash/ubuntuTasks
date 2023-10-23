#!/bin/bash 

set -ex

echo "Update apt and install nginx"
sudo apt-get update
sudo apt-get install nginx

echo "Enable nginx"
sudo systemctl enable nginx

sudo systemctl is-enabled nginx

echo "Create web site folder"
sudo mkdir -p /var/www/firstSite/html

echo "Create web page file"
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

echo "Create web config file"
echo "server {
    listen 22;
    listen [::]:888;

    root /var/www/firstSite/html;
    index index.html;
}" | sudo tee /etc/nginx/sites-available/firstSite.conf 


echo "Enable web config via link"
sudo ln -s /etc/nginx/sites-available/firstSite.conf /etc/nginx/sites-enabled/

echo "Check if nginx configured properly"
sudo nginx -t

echo "Remove default web config"
sudo rm /etc/nginx/sites-enabled/default

echo "Restart nginx"
sudo systemctl restart nginx


