# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
    config.vm.box = "ubuntu-11.10"
    config.vm.customize["modifyvm", :id, "--memory", "2048"]
    config.vm.network :hostonly, "33.33.33.40"
    config.vm.share_folder("v-root", "/vagrant", ".", :nfs => true)

    config.vm.provision :puppet do |puppet|
        puppet.manifests_path = "manifests"
        puppet.manifest_file  = "base.pp"
    end
end
