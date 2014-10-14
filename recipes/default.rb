#
# Cookbook Name:: myapache-cookbook
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

package 'apache2 do
  action :install
end

# punter 'root'
file '/tmp/something' do
  action :create
end
