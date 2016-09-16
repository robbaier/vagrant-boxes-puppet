# Fix file permissions after all other provisioning is done
chown -c vagrant:vagrant /home/vagrant/.bash_aliases
chown -c vagrant:vagrant /home/vagrant/wp-completion.bash
