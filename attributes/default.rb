# Attributes used by the app-checkout recipe
default['myapache-cookbook']['doc-root'] = '/var/www/html'
default['myapache-cookbook']['git-repo'] = 'https://github.com/alexpop/myhtml-app'
default['myapache-cookbook']['git-revision'] = 'master'

# Attributes used by the basic_auth recipe
default['myapache-cookbook']['auth_user'] = nil
default['myapache-cookbook']['auth_pass_hash'] = nil

# Attributes used by the ssl recipe
default['data_bag']['name'] = 'OVERRIDE-ME'
default['data_bag']['item'] = 'OVERRIDE-ME'
default['data_bag']['secret'] = 'OVERRIDE-ME'

