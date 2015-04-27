#
# Cookbook Name:: myapache-cookbook
# Recipe:: sandbox
#
# Copyright 2015, Great Websites Inc
#

log '*** Hello from myapache-cookbook::troubleshooting'

ten = 0

chef_gem "pry-byebug" do
  compile_time true
end
require "pry-byebug"

if (node['myapache-cookbook']['ap_path'])
  chef_gem 'awesome_print' do
    source node['myapache-cookbook']['ap_path']
	  compile_time true
  end
  require 'awesome_print'
end

require 'pry'
binding.pry

ten=5+5

if (Chef::Config[:chef_server_url] !~ /\/organizations\//)
  log "*** 'organizations' is missing from the url!!!"
end

log '*** End of recipe'

