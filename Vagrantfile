# Create a minimal Ubuntu box
Vagrant.require_version ">= 1.8.6"
Vagrant.configure(2) do |config|


    # Configure the base box
    config.vm.define "ubuntu" do |ubuntu|

        # Use a 32bit version for workshops to avoid issues with 64bit virtualization
        # But use 64bit for Docker demos, since it requires a 64bit host
        # Avoid https://atlas.hashicorp.com/ubuntu/ since those are notoriously broken
        ubuntu.vm.box = "bento/ubuntu-16.04"
        ubuntu.vm.hostname = "meetup-kafka-elastic"
        ubuntu.vm.network :forwarded_port, guest: 5601, host: 5681
        ubuntu.vm.network :forwarded_port, guest: 3306, host: 3306
        ubuntu.vm.synced_folder "kafka-elastic/", "/kafka-elastic/"
    end


    # Configure the VirtualBox parameters
    config.vm.provider "virtualbox" do |vb|
        vb.name = "meetup-kafka-elastic"
        vb.customize [ "modifyvm", :id, "--memory", "2560" ]
    end


    # Configure the box with Ansible
    config.vm.provision "ansible_local" do |ansible|
        ansible.playbook = "/kafka-elastic/0_install.yml"
    end


end
