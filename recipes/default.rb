#
# Cookbook Name:: myapache-cookbook
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

package "apache2" do
  action :install
end

file "/tmp/something" do
#  punter "root"
  action :create
end


