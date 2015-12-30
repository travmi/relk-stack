rm -rf /etc/ansible/roles
rm -rf /etc/ansible/playbooks
rsync -av --delete /vagrant/config/ansible.cfg /etc/ansible/ansible.cfg
rsync -av --delete /vagrant/config/hosts /etc/ansible/hosts
rsync -av --delete /vagrant/roles /etc/ansible/
rsync -av --delete /vagrant/playbooks /etc/ansible/
chown root:root -R /etc/ansible
chmod 644 -R /etc/ansible
