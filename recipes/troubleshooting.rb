#
# Cookbook Name:: myapache-cookbook
# Recipe:: troubleshooting
#
# Copyright 2015, Great Websites Inc
#

require 'pp'
# Debug a node attribute(ie: node['myapache-cookbook']['ap_path']) to see where is the value set, etc
pp node.debug_value('myapache-cookbook', 'ap_path')

# Only enter here if chef-client is run from /tmp
# This prevents scheduled runs from hanging in `binding.pry`
if (ENV['PWD'] == '/tmp')
  # Really good gem to pretty print hashes, objects, etc
  if node['myapache-cookbook']['ap_path']
    chef_gem 'awesome_print' do
      source node['myapache-cookbook']['ap_path']
      compile_time true
    end
    require 'awesome_print'
  end
  # gem 'pry-byebug' can be used to step through

  # Used to stop the chef-client run a provide a pry prompt to the user
  # Extremly useful for troubleshooting purposes.
  require 'pry'
  binding.pry
end

if Chef::Config[:chef_server_url] !~ %r{/organizations/}
  Chef::Log.warn('*** "organizations" is missing from the url!')
end
