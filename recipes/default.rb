#
# Cookbook Name:: myapache-cookbook
# Recipe:: default
#
# Copyright 2014, Great Blogs Ltd
#
# All rights reserved - Do Not Redistribute

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

directory "/tmp/bf" do
	action :create
end
