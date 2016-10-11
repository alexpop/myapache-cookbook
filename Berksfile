# Get dependencies from the Chef Supermarket
# If you don't want a source, use a fake one: 'https://localhost:55555'
source 'https://supermarket.chef.io'

# Look for dependencies in ./metadata.rb
metadata

cookbook 'audit'
# or use my local audit cookbook clone:
#cookbook 'audit', path: '../audit'

# Use a dependent cookbook from the parent folder
# cookbook 'pci', path: '../pci'

# Specify dependent cookbook. Useful when you don't have a local ./metadata.rb
# cookbook 'java'
# More examples on how to specify the location for dependent cookbooks
# cookbook 'apache', git: 'https://bitbucket.org/johndoe/apache.git'
# cookbook 'mydns-cookbook', github: 'alexpop/mydns-cookbook', tag: "0.3.4"
# cookbook 'mysql', git: 'https://mygitlab.com/test-org/cookbooks.git'
# cookbook 'jboss', git: 'https://github.com/test-org/many_cookbooks.git', rel: 'cookbooks/jboss'
# cookbook 'mediawiki', github: 'millisami/chef-mediawiki'
