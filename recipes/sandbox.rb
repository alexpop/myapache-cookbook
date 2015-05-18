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

Chef::Log.warn "*** Should show on -l warn"

# Find all string in the array that contain
# 'site_ruby/' without a '/' after that
site_ruby_paths = $LOAD_PATH.grep(/site_ruby\/[^\/]+$/)
if (site_ruby_paths.empty?)
  raise "*** Cannot find the site_ruby path, aborting..."
else
  site_ruby_path=site_ruby_paths.first
  Chef::Log.warn "*** site_ruby is at: #{site_ruby_path}"
end

if (Chef::Config[:chef_server_url] !~ /\/organizations\//)
  log "*** 'organizations' is missing from the url!!!"
end

log '*** End of recipe'

execute "multi_line_script" do
  command <<-EOH
    set -x
    date > /tmp/date.txt
    whoami
    sleep 4
    pwd
    date >> /tmp/date.txt
  EOH
  timeout 10
	creates '/tmp/date.txt'
  action :run
end

