#
# Cookbook Name:: myapache-cookbook
# Recipe:: ssl
#
# Copyright 2014, Great Websites Inc
#

log '*** Hello from myapache-cookbook::ssl'

# Create the directory during compile time to be available for the file resource
directory '/etc/chef/' do
  mode '0700'
  action :nothing
end.run_action(:create)

# Create the file during compile time to be available for the load_secret method
file '/etc/chef/encrypted_data_bag_secret' do
  content node['data_bag']['secret']
  mode '0600'
  sensitive true
  action :nothing
end.run_action(:create)

# Load the secret from disk and decrypt the databag item specified in the attributes
secret_path = Chef::EncryptedDataBagItem.load_secret('/etc/chef/encrypted_data_bag_secret')
ssl = Chef::EncryptedDataBagItem.load(node['data_bag']['name'], node['data_bag']['item'], secret_path)

directory '/etc/ssl/' do
  mode '0700'
  action :create
end

# Create the certificate using the sensitive option to avoid logging the content
file '/etc/ssl/certificate.crt' do
  content ssl['cert']
  mode '0600'
  sensitive true
  action :create
end

file '/etc/ssl/certificate.key' do
  content ssl['key']
  mode '0600'
  sensitive true
  action :create
end
