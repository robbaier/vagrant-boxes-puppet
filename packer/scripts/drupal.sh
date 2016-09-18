# Install Drush
cd /usr/local/bin
php -r "readfile('https://s3.amazonaws.com/files.drush.org/drush.phar');" > drush
cd
php /usr/local/bin/drush core-status
chmod +x /usr/local/bin/drush

# Enrich the bash startup file with completion and aliases
sudo -u vagrant /usr/local/bin/drush init -y
