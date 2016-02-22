#
# Cookbook Name:: myapache-cookbook
# Recipe:: ssl
#
# Copyright 2015, Great Websites Inc
#

execute 'name' do
  command 'command'
  action :run
end

# array of packages supported only on chef-clinet 12.1.0 or above
package %w(mod_ssl openssl) do
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
  notifies :reload, 'service[httpd]'
  notifies :run, 'ruby_block[ssl_script]'
end

file '/etc/ssl/certificate.key' do
  content ssl['key']
  mode '0600'
  sensitive true
  action :create
  notifies :reload, 'service[httpd]'
end

# Executed in the compile phase and will be overridden by `ruby_block[ssl_script]` if the cert is changed during converge
# get_expire_days is a helper method defined in `libraries/helpers.rb`
node.set['ssl_cert']['expire_days'] = get_expire_days('/etc/ssl/certificate.crt')
# Only executed when the cert file is created/updated during the converge phase
ruby_block 'ssl_script' do
  block do
    # Set normal attribute to easily search nodes for the SSL expiration date
    node.set['ssl_cert']['expire_days'] = get_expire_days('/etc/ssl/certificate.crt')
  end
  action :nothing
end

service 'httpd' do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end

expire_days = node['ssl_cert']['expire_days']
control_group 'Apache' do
  control 'SSL' do
    it 'should have more than 30 days before expiring' do
      expect(expire_days).to be > 30
    end
  end
end
