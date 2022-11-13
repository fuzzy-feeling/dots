#!/bin/bash

read -p"Enter Username: " user

# tag::install_dependencies[]
apt-get install curl -y
# end::install_dependencies[]

# tag::install_syncthing[]
# download gpg key
curl -o /usr/share/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg

# add gpg key to sources.list
echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list

# update sources ad install syncthing
apt-get update
apt-get install syncthing -y

# enable and start syncthing as systemd service
systemctl enable syncthing@$user.service
systemctl start syncthing@$user.service

# use ed to replace ipv4 address for externel webui
sed -i "s/<address>127.0.0.1:8384<\/address>/<address>0.0.0.0:8384<\/address>/g" /home/$user/.config/syncthing/config.xml

# end::install_syncthing[]


# tag::install_adoc[]
sudo -u $user export GEM_HOME=~/.gem
sudo -u $user export GEM_PATH=~/.gem
sudo -u $user gem install asciidoctor
sudo -u $user gem install asciidoctor-diagram
sudo -u $user gem install asciidoctor-pdf
# end::install_adoc[]



# tag::install_ufw[]
apt-get install ufw -y
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw enable
# end::install_ufw[]


# tag::install_sudo[]
apt-get install sudo
usermod -aG sudo $user
# end::install_sudo[]
