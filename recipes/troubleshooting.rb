#
# Cookbook Name:: myapache-cookbook
# Recipe:: sandbox
#
# Copyright 2015, Great Websites Inc
#

# Add local mode command to history in case it needs to be run manually after login
file '/root/.bash_history' do
  content '/opt/chef/bin/chef-client --local-mode --config /tmp/kitchen/client.rb --log_level auto --force-formatter --no-color --json-attributes /tmp/kitchen/dna.json --chef-zero-port 8889'
  mode '0600'
  action :create_if_missing
end

require 'pp'
# debug a node attribute(ie: node['myapache-cookbook']['ap_path']) to see where is the value set, etc
pp node.debug_value('myapache-cookbook', 'ap_path')

# only enter here if chef-client is run from /tmp
if(ENV['PWD'] == '/tmp')
  if (node['myapache-cookbook']['ap_path'])
    chef_gem 'awesome_print' do
      source node['myapache-cookbook']['ap_path']
      compile_time true
    end
    require 'awesome_print'
  end
  # gem 'pry-byebug' can be used to step through

  require 'pry'
  binding.pry
end


if (Chef::Config[:chef_server_url] !~ /\/organizations\//)
  Chef::Log.warn("*** 'organizations' is missing from the url!")
end

Chef::Log.warn('*** End of recipe')

