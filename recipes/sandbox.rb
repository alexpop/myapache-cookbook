#
# Cookbook Name:: myapache-cookbook
# Recipe:: sandbox
#
# Copyright 2015, Great Websites Inc
#

#remote_file '/tmp/logo.svg' do
#  source "https://ap-local-core-services.opschef.tv/hook.log"
#  action :create
#end

Chef::Log.warn "*** Should show on -l warn"

# Find all strings in the array that contain
# 'site_ruby/' without a '/' after that
site_ruby_paths = $LOAD_PATH.grep(/site_ruby\/[^\/]+$/)
if (site_ruby_paths.empty?)
  raise "*** Cannot find the site_ruby path, aborting..."
else
  site_ruby_path=site_ruby_paths.first
  Chef::Log.warn "*** site_ruby is at: #{site_ruby_path}"
end

if (Chef::Config[:chef_server_url] !~ /\/organizations\//)
  Chef::Log.warn("*** 'organizations' is missing from the url!!!")
end


execute "multi_line_script" do
  command <<-EOH
    whoami
    ls /etc
  EOH
  action :run
end

bash 'test1' do
  code 'touch /tmp/test.txt'
  creates "/tmp/test.txt"
end

bash 'test2' do
  code 'touch /tmp/test.txt'
  not_if { File.exists?('/tmp/test.txt') }
end
