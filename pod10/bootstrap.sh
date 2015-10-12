sudo apt-get install
sudo apt-get install -y openssh-server openssh-client
sudo apt-get install -y puppet puppetmaster
sudo ufw disable
sudo sed -i -e '2i10.50.15.90 puppetmaster.netbuilder.private puppetmaster' /etc/hosts
sudo sed -i -e '2i127.0.0.1   puppetmaster.netbuilder.private' /etc/hosts
sudo touch /etc/puppet/manifests/site.pp
sudo touch /etc/puppet/autosign.conf
sudo echo 'agent0.netbuilder.private' >> /etc/puppet/autosign.conf
