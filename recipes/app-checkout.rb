#
# Cookbook Name:: myapache-cookbook
# Recipe:: app-checkout
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

package 'git' do
  action :install
end

git node['myapache-cookbook']['doc-root'] do
  repository node['myapache-cookbook']['git-rep']
  revision 'master'
  action :sync
end
