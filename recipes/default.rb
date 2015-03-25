#
# Cookbook Name:: myapache-cookbook
# Recipe:: default
#
# Copyright 2014, Great Blogs Ltd
#
# All rights reserved - Do Not Redistribute

log "*** Deploying myapache-cookbook::default in environment #{node.chef_environment}"

log "*** Time in epoch is: #{lib_epoch}"

package "httpd" do
  action :upgrade
end

service "httpd" do
  action [:enable, :start]
end

service 'iptables' do
  action [:disable, :stop]
end

package "tree" do
	action :upgrade
end

directory "/tmp/test" do
  action :create
end

file "/tmp/wed.txt" do
	content "aaaaaaaaaaa"
end
