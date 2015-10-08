#
# Cookbook Name:: myapache-cookbook
# Recipe:: app_checkout
#

# Install the 'git' packge from software repositories
package 'git' do
  action :upgrade
end

# Use the 'git' resource to checkout from the provided repository
git node['myapache-cookbook']['doc-root'] do
  repository node['myapache-cookbook']['git-repo']
  revision node['myapache-cookbook']['git-revision']
  notifies :run, 'ruby_block[retrieve_app_version]'
  action :sync
end

# Get the app version from VERSION.txt and add it to the node data
ruby_block 'retrieve_app_version' do
  block do
    version = File.open("#{node['myapache-cookbook']['doc-root']}/VERSION.txt").readline.chomp
    node.set['myapache-cookbook']['app-ver'] = version
  end
  only_if { File.exist?("#{node['myapache-cookbook']['doc-root']}/VERSION.txt") }
  notifies :create, 'file[/tmp/app-ver.txt]'
  action :nothing
end

# Pass the app version to the file resource in the compile phase using lazy
file '/tmp/app-ver.txt' do
  owner 'root'
  group 'root'
  content lazy { "Parsed version: #{node['myapache-cookbook']['app-ver']}" }
  notifies :create, 'file[/tmp/app-ver.txt]'
  action :nothing
end

# Iterate through all items is the 'files' data bag
search('files', '*:*').each do |file|
  file "#{node['myapache-cookbook']['doc-root']}/#{file['id']}" do
    content file['content']
    mode file['mode']
    action :create
  end
end
