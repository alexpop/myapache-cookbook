# Get dependencies from the Chef Supermarket
source 'https://supermarket.chef.io'
# If you don't want a source, use a fake one: 'https://localhost:55555'

# Look for dependencies in ./metadata.rb
metadata

cookbook 'mydns-cookbook', path: '../mydns-cookbook'

# Specify dependent cookbook. Useful when you don't have a local ./metadata.rb
# cookbook 'java'

# More examples on how to specify the location for dependent cookbook
# cookbook ‘gitlab', git: ‘https://gitlab.com/gitlab-org/cookbook-gitlab.git'
# cookbook ‘gitlab', git: ‘https://mygitlab.com/test-org/cookbooks.git'
# cookbook "jboss", git: "https://github.com/test-org/many_cookbooks.git", rel: "cookbooks/jboss"
# cookbook 'mediawiki', github: 'millisami/chef-mediawiki'
