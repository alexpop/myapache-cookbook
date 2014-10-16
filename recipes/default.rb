#
# Cookbook Name:: myapache-cookbook
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

package node['myapache-cookbook']['package'] do
  action :install
end

file '/var/www/index.html' do
  content "<h1>Hello #{node['myapache-cookbook']['name']}</h1>"
  mode '0644'
  action :create
end
