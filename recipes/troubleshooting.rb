#
# Cookbook Name:: myapache-cookbook
# Recipe:: sandbox
#
# Copyright 2015, Great Websites Inc
#

# Avoiding 'kitchen converge' runs
if(ENV['SUDO_COMMAND'] =~ /chef-client --local-mode/)
  Chef::Log.warn("Detected kitchen run, skipping 'binding.pry'")
else
  if (node['gem'] && node['gem']['ap_path'])
    chef_gem 'awesome_print' do
      source node['gem']['ap_path']
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

