
# Installing vagrant keys
mkdir -pm 700 /home/vagrant/.ssh
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R -c vagrant:vagrant /home/vagrant/.ssh

cat > /home/vagrant/.ssh/config <<EOF
Host *
    ForwardAgent yes
    StrictHostKeyChecking no
    UserKnownHostsFile=/dev/null

EOF

chmod 0600 /home/vagrant/.ssh/config
