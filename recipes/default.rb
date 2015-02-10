#
# Cookbook Name:: myapache-cookbook
# Recipe:: default
#
# Copyright 2014, Great Blogs Ltd
#
# All rights reserved - Do Not Redistribute

log "*** Deploying myapache-cookbook::default in environment #{node.chef_environment}"

log "*** Time in epoch is: #{lib_epoch}"

case node['platform_family']
when 'debian'
  package_name = 'apache2'
when 'rhel'
  package_name = 'httpd'
end

package "#{package_name}" do
  action :install
end

service "#{package_name}" do
  action [:enable, :start]
end

service 'iptables' do
  action [:disable, :stop]
end

package "tree" do
	action :install
end
