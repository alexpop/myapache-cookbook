#
# Cookbook Name:: myapache-cookbook
# Recipe:: app-checkout
#

# Install the 'git' packge from software repositories
package 'git' do
  action :install
end

# Add app version to node data. Unknown for now
node.set['myapache-cookbook']['app-ver'] = 'unknown'

# Use the 'git' resource to checkout from the provided repository
git node['myapache-cookbook']['doc-root'] do
  repository node['myapache-cookbook']['git-repo']
  revision node['myapache-cookbook']['git-revision']
  action :sync
end

bash 'dir git folder' do
  flags '-ex'
  code <<-EOH
    ls -la /var/www/html/
    echo "*** Hello World"
  EOH
end

# Iterate through all items is the 'files' data bag
search('files', '*:*').each do |file|
  file "#{node['myapache-cookbook']['doc-root']}/#{file['id']}" do
    content file['content']
    mode file['mode']
  end
end

# Get the app version from VERSION.txt and add it to the node data
ruby_block 'Retrieve app version' do
  block do
    version = File.open("#{node['myapache-cookbook']['doc-root']}/VERSION.txt").readline.chomp
    node.set['myapache-cookbook']['app-ver'] = version
  end
  only_if { File.exist?("#{node['myapache-cookbook']['doc-root']}/VERSION.txt") }
end

# Pass the app version to the file resource in the compile phase using lazy
file '/tmp/app-ver.txt' do
  owner 'root'
  group 'root'
  content lazy { "Parsed version: #{node['myapache-cookbook']['app-ver']}" }
end
