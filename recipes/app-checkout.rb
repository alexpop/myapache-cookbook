#
# Cookbook Name:: myapache-cookbook
# Recipe:: app-checkout
#

# Install the 'git' packge from software repositories
package 'git' do
  action :install
end

# Use the 'git' resource to checkout from the provided repository
git node['myapache-cookbook']['doc-root'] do
  repository node['myapache-cookbook']['git-repo']
  revision node['myapache-cookbook']['git-revision']
  action :sync
end

# Iterate through all item is the 'files' data bag
search('files', '*:*').each do |file|
  file "#{node['myapache-cookbook']['doc-root']}/#{file['name']}" do
    content file['content']
    mode file['mode']
  end
end
