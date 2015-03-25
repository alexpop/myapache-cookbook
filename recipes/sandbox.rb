#
# Cookbook Name:: myapache-cookbook
# Recipe:: sandbox
#
# Copyright 2015, Great Websites Inc
#

log '*** Hello from myapache-cookbook::sandbox'

remote_file '/tmp/logo.svg' do
  source "https://ap-local-core-services.opschef.tv/hook.log"
  action :create
end
