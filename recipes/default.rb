#
# Cookbook Name:: myapache-cookbook
# Recipe:: default
#
# Copyright 2014, Great Blogs Ltd
#
# All rights reserved - Do Not Redistribute

Chef::Log.warn "*** Time in epoch is: #{lib_epoch}"

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
  action :install
end
