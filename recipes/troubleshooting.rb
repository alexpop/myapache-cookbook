#
# Cookbook Name:: myapache-cookbook
# Recipe:: troubleshooting
#
# Copyright 2015, Great Websites Inc
#

# Really good gem to pretty print hashes, objects, etc
if ENV['PWD'] == '/tmp'
  require 'pp'
  # Debug a node attribute(ie: node['myapache-cookbook']['git-repo']) to see where is the value set, etc
  pp node.debug_value('myapache-cookbook', 'git-repo')
  chef_gem 'awesome_print' do
    compile_time true
  end
  require 'awesome_print'
end

# Only enter here if chef-client is run from /tmp
# This prevents scheduled runs from hanging in `binding.pry`
if ENV['PWD'] == '/tmp'
  # Stop chef-client and provide a `pry` prompt for troubleshooting
  require 'pry'
  binding.pry
end
