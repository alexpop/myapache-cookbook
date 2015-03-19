#
# Cookbook Name:: myapache-cookbook
# Recipe:: ssl
#
# Copyright 2014, Great Websites Inc
#

log '*** Hello from myapache-cookbook::ssl'

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
  notifies :run, 'ruby_block[ssl_script]', :immediately
end

file '/etc/ssl/certificate.key' do
  content ssl['key']
  mode '0600'
  sensitive true
  action :create
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
  action :nothing
end
