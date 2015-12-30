# -*- mode: ruby -*-
# vi: set ft=ruby :

$hostnames = <<EOF
echo "Setting up /etc/hosts"
echo -e "172.16.81.4\tansible\n172.16.81.5\tkibana\n172.16.81.6\tredis\n172.16.81.7\tlogstash\n172.16.81.8\telasticsearch\n172.16.81.9\tsyslog\n172.16.81.10\tclient\n" >> /etc/hosts
EOF

# Install packages I like
$packages = <<EOF
echo "Installing extra packages"
yum update -y
yum install vim git rsync wget telnet bind-utils traceroute net-tools epel-release dos2unix -y
setenforce 0
sed -i s/SELINUX=enforcing/SELINUX=disabled/g /etc/selinux/config
EOF

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define "ansible" do |ansible|
     ansible.vm.box = "geerlingguy/centos7"
     ansible.vm.hostname = "ansible"
     ansible.vm.network :private_network, ip: "172.16.81.4"
     ansible.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512"]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
     end
     ansible.vm.provision "shell", inline: "yum install ansible rsync -y; rsync -av /vagrant/config/ansible.cfg /etc/ansible/ansible.cfg; rsync -av /vagrant/config/hosts /etc/ansible/hosts"
     ansible.vm.provision "shell", inline: "ln -s /vagrant/bin/sync.sh sync; cd /etc/ansible; ln -s /vagrant/bin/sync.sh sync"
 end

 config.vm.define "kibana" do |kibana|
    kibana.vm.box = "geerlingguy/centos7"
    kibana.vm.hostname = "kibana"
    kibana.vm.network :private_network, ip: "172.16.81.5"
    kibana.vm.network :forwarded_port, guest: 80, host: 80
    kibana.vm.provider "virtualbox" do |vb|
     vb.customize ["modifyvm", :id, "--memory", "512"]
     vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    end
 end

 config.vm.define "redis" do |redis|
    redis.vm.box = "geerlingguy/centos7"
    redis.vm.hostname = "redis"
    redis.vm.network :private_network, ip: "172.16.81.6"
    redis.vm.provider "virtualbox" do |vb|
     vb.customize ["modifyvm", :id, "--memory", "512"]
     vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    end
  end

 config.vm.define "logstash" do |logstash|
    logstash.vm.box = "geerlingguy/centos7"
    logstash.vm.hostname = "logstash"
    logstash.vm.network :private_network, ip: "172.16.81.7"
    logstash.vm.provider "virtualbox" do |vb|
     vb.customize ["modifyvm", :id, "--memory", "512"]
     vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    end
  end

  config.vm.define "elasticsearch" do |elasticsearch|
     elasticsearch.vm.box = "geerlingguy/centos7"
     elasticsearch.vm.hostname = "elasticsearch"
     elasticsearch.vm.network :private_network, ip: "172.16.81.8"
     elasticsearch.vm.network :forwarded_port, guest: 9200, host: 9200
     elasticsearch.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024"]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
     end
     elasticsearch.vm.preovision "shell", inline: ""
   end

   config.vm.define "syslog" do |syslog|
      syslog.vm.box = "geerlingguy/centos7"
      syslog.vm.hostname = "syslog"
      syslog.vm.network :private_network, ip: "172.16.81.9"
      syslog.vm.provider "virtualbox" do |vb|
       vb.customize ["modifyvm", :id, "--memory", "512"]
       vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      end
    end

   config.vm.define "client" do |client|
      client.vm.box = "geerlingguy/centos7"
      client.vm.hostname = "client"
      client.vm.network :private_network, ip: "172.16.81.10"
      client.vm.provider "virtualbox" do |vb|
       vb.customize ["modifyvm", :id, "--memory", "512"]
       vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      end
    end

  hosts = ["ansible", "kibana", "redis", "logstash", "elasticsearch", "syslog", "client"]
  hosts.each do |i|
    config.vm.define "#{i}" do |node|
        node.vm.provision "shell", inline: $hostnames
        node.vm.provision "shell", inline: $packages
    end
  end

#  clients = ["agent1", "agent2", "agent3"]
#  clients.each do |i|
#    config.vm.define "#{i}" do |node|
#    	node.vm.provision "shell",
#      	  inline: ""
#        node.vm.provision "shell",
#          inline: ""
#    end
#  end

end
