# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.8.1"

require "json"

manifests = File.join(File.dirname(__FILE__), 'manifest.json')
servers = JSON.parse(File.read(manifests))

Vagrant.configure(2) do |config|

  servers.each do |server|
    config.vm.define server["name"] do |serv|
      serv.vm.hostname = server["hostname"]
      serv.vm.box = server["box"]

      serv.vm.network "forwarded_port", guest: 22, host: server["ssh_guest_port"]
      serv.vm.network "private_network", ip: server["private_ip_addr"]

      if server.has_key?("sync")
        server["sync"].each do |sync|
          serv.vm.synced_folder sync["source"], sync["destination"]
        end
      end

      serv.ssh.forward_agent = true
      serv.ssh.guest_port = server["ssh_guest_port"]

      serv.vm.provider "virtualbox" do |vb|
        vb.gui = false
        vb.memory = server["ram"]
        vb.cpus = server["vcpu"]
        vb.name = server["name"]
        vb.customize [
          "modifyvm", :id,
          "--paravirtprovider", "kvm"
        ]
      end

      serv.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

      if server.has_key?("scripts")
        server["scripts"].each do |script|
          serv.vm.provision "shell" do |s|
            s.path = script[0]
            s.args = script[1]
          end
        end
      end

      if server.has_key?("puppet") && server["puppet"].has_key?("manifest")
        serv.vm.provision "puppet" do |puppet|
          puppet.manifest_file = server["puppet"]["manifest"]
          puppet.manifests_path = "puppet_manifest"
          puppet.module_path = "puppet_modules"
          puppet.options = "--verbose --debug"
        end
      end

    end
  end
end
