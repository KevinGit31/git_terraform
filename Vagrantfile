# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "serverterraform" do |serverterraform|
    serverterraform.vm.box = "ubuntu/bionic64"
    serverterraform.vm.hostname = 'serverterraformmaster'
    #serverterraform.vm.provision "docker"
    serverterraform.vm.box_url = "ubuntu/bionic64"
	serverterraform.vm.box_download_insecure = true
    serverterraform.vm.network :private_network, ip: "192.168.56.104"

    serverterraform.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 2048]
      v.customize ["modifyvm", :id, "--name", "serverterraformmaster"]
      v.customize ["modifyvm", :id, "--cpus", "2"]
    end
	serverterraform.vm.synced_folder "project/", "/home/project", create: true
	#serverterraform.vm.provision :shell, :path => "provision_master.sh"
  end
end
