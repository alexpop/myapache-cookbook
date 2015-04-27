#
# Cookbook Name:: myapache-cookbook
# Recipe:: ssl
#
# Copyright 2015, Great Websites Inc
#

log '*** Hello from myapache-cookbook::ssl'

# array of packages supported only on chef-clinet 12.1.0 or above
package ['mod_ssl', 'openssl'] do
  action :upgrade
end

# data_bag_item is a new core resource as of chef-client 12
# if the secret is not specified here, it will be looked based on the 'encrypted_data_bag_secret' client.rb option
ssl = data_bag_item(node['data_bag']['name'], 
                    node['data_bag']['item'], 
                    node['data_bag']['secret'])

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
  notifies :reload, "service[httpd]"
end

file '/etc/ssl/certificate.key' do
  content ssl['key']
  mode '0600'
  sensitive true
  action :create
  notifies :reload, "service[httpd]"
end

# Only executed when the cert file is created/updated
ruby_block "ssl_script" do
  block do
    cert = OpenSSL::X509::Certificate.new(File.read('/etc/ssl/certificate.crt'))
    expire_days = ((cert.not_after-Time.now)/86400).to_i
    # Set attributes to easily search nodes for SSL expiration dates
    node.set['ssl_cert']['not_after'] = cert.not_after
    node.set['ssl_cert']['expire_days'] = expire_days
    # Fail the recipe to prevent certificate expiration issues
    if expire_days<=30
      raise "Only SSL certificates above 30 days from expiration are allowed. "+
            "Number of days left: #{expire_days}. Negative number indicates expired certificate"
    end
  end
  action :run
end

service "httpd" do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end
