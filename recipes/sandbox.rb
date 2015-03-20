#
# Cookbook Name:: myapache-cookbook
# Recipe:: sandbox
#
# Copyright 2015, Great Websites Inc
#

log '*** Hello from myapache-cookbook::sandbox'

remote_file '/tmp/logo.svg' do
  source "https://184.106.28.83/images/logo.svg"
  action :create
end
