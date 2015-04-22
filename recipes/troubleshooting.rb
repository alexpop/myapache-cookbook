#
# Cookbook Name:: myapache-cookbook
# Recipe:: sandbox
#
# Copyright 2015, Great Websites Inc
#

log '*** Hello from myapache-cookbook::troubleshooting'

#remote_file '/tmp/logo.svg' do
#  source "https://ap-local-core-services.opschef.tv/hook.log"
#  action :create
#end

ten = 0

#chef_gem "pry-byebug" do
# compile_time true
#end
#require "pry-byebug"
#chef_gem 'awesome_print' do
#  compile_time true
#end
#require 'awesome_print'
require 'pry'
binding.pry

ten=5+5

if (Chef::Config[:chef_server_url] !~ /\/organizations\//)
  log "*** 'organizations' is missing from the url!!!"
end

log '*** End of recipe'

