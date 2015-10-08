#
# Cookbook Name:: myapache-cookbook
# Recipe:: sandbox
#
# Copyright 2015, Great Websites Inc
#

Chef::Log.warn '*** Should show on -l warn'

# Find all strings in the array that contain
# 'site_ruby/' without a '/' after that
site_ruby_paths = $LOAD_PATH.grep(%r{site_ruby/[^/]+$})
if site_ruby_paths.empty?
  fail '*** Cannot find the site_ruby path, aborting...'
else
  site_ruby_path = site_ruby_paths.first
  Chef::Log.warn "*** site_ruby is at: #{site_ruby_path}"
end

if Chef::Config[:chef_server_url] !~ %r(/organizations/)
  Chef::Log.warn('*** "organizations" is missing from the url!!!')
end

# For unit test mocking
bash 'test1' do
  code 'touch /tmp/test.txt'
  creates '/tmp/test.txt'
end

bash 'test2' do
  code 'touch /tmp/test.txt'
  not_if { File.exist?('/tmp/test.txt') }
end
