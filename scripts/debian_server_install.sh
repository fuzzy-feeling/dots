#!/bin/bash


read -p"Enter Username: " user

# tag::install_dependencies[]
apt-get update
apt-get install curl -y
# end::install_dependencies[]


# tag::install_sudo[]
apt-get install sudo
usermod -aG sudo $user
# end::install_sudo[]


# tag::install_ufw[]
apt-get install ufw -y
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw enable
# end::install_ufw[]


# tag::install_adoc[]
apt-get install gem -y
sudo -u $user export GEM_HOME=~/.gem
sudo -u $user export GEM_PATH=~/.gem
sudo -u $user gem install asciidoctor
sudo -u $user gem install asciidoctor-diagram
sudo -u $user gem install asciidoctor-pdf
# end::install_adoc[]


# tag::install_syncthing[]
curl -o /usr/share/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg
echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
apt-get update
apt-get install syncthing -y
systemctl enable syncthing@$user.service
systemctl start syncthing@$user.service
sed -i "s/<address>127.0.0.1:8384<\/address>/<address>0.0.0.0:8384<\/address>/g" /home/$user/.config/syncthing/config.xml
systemctl restart syncthing@$user.service
ufw allow syncthing-gui
# end::install_syncthing[]


# tag::install_mulvad[]
apt-get install curl jq openresolv wireguard
# end::install_mulvad[]
