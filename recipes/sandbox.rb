#
# Cookbook Name:: myapache-cookbook
# Recipe:: sandbox
#
# Copyright 2015, Great Websites Inc
#

log '*** Hello from myapache-cookbook::sandbox'

#remote_file '/tmp/logo.svg' do
#  source "https://ap-local-core-services.opschef.tv/hook.log"
#  action :create
#end


#if(Chef::Config[:chef_server_url] !~ /\/organizations\//)
   #Chef::Config[:chef_server_url]+="/organizations/searsil"
#   node.default['chef_client']['config']['chef_server_url']="#{Chef::Config[:chef_server_url]}/organizations/searsil"
#end

log "*** Content of Chef::Config is '#{Chef::Config.inspect}'"


#config_dir = File.expand_path('..', Config)

