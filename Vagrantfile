Vagrant.configure("2") do |config|
  # Name of the box to use
  config.vm.box = "trusty64"

  # Choosing Provision config file, removing sudo rights
  config.vm.provision :shell, :path => "vm_provision/provision-ubuntu-14.04.sh", :privileged => false

  # Opening ports
  config.vm.network "forwarded_port", guest: "1025", host: "1025"
  config.vm.network "forwarded_port", guest: "1080", host: "1080"
  config.vm.network "forwarded_port", guest: "3000", host: "3000"
  config.vm.network "forwarded_port", guest: "3001", host: "3001"
  config.vm.network "forwarded_port", guest: "8091", host: "8091"
  config.vm.network "forwarded_port", guest: "8080", host: "8080"
  config.vm.network "forwarded_port", guest: "8081", host: "8081"
  config.vm.network "forwarded_port", guest: "6379", host: "6379"
  config.vm.network "forwarded_port", guest: "9200", host: "9200"

  # Setting boot timeout
  config.vm.boot_timeout = 10000

  # Configuring username and password when booting vm to avoid an issue
  config.ssh.username = 'vagrant'
  config.ssh.password = 'vagrant'

  # Setting 2gb of ram for vm to use
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "90", "--cpus", "2"]
    vb.memory = 2000
  end
end
