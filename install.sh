#!/bin/bash

yum_repos() {
  # Installing EPEL
  yum -y --nogpgcheck install http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
  # Installing Puppet Labs yum
  yum -y --nogpgcheck install http://yum.puppetlabs.com/el/6/products/x86_64/puppetlabs-release-6-6.noarch.rpm
}

yum_update() {
  yum -y update
}

yum_install() {
  # Only dependancies required to bootstrap
  yum -y install puppet facter hiera ruby-augeas ruby-shadow augeas git
}

puppet_apply() {
  puppet apply \
    --hiera_config /etc/puppet/hiera.yaml \
    --modulepath /etc/puppet/modules \
    /etc/puppet/manifests/site.pp
}

write_done() {
  touch ~/provisioner_complete
}

first_run() {
  if [ ! -f ~/provisioner_complete ]; then
    yum_repos
    yum_update
    yum_install
    write_done
  fi
}

first_run
puppet_apply
