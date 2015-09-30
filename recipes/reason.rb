#
# Cookbook Name:: myapache-cookbook
# Recipe:: reason
#

file '/opt/chef/reason.txt' do
  content node['myapache-cookbook']['reason']
  notifies :write, 'log[run_reason]' 
end

log "run_reason" do
  message "REASON FOR RUNNING: #{node['myapache-cookbook']['reason']}"
  action :nothing
end

# A better solution for Windows nodes
#env 'REASON' do
#  value "REASON FOR RUNNING: #{node['myapache-cookbook']['reason']}"
#end
