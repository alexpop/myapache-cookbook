case node['platform_family']
when 'debian'
  default['myapache-cookbook']['package'] = 'apache2'
when 'rhel'
  default['myapache-cookbook']['package'] = 'httpd'
end

default['myapache-cookbook']['apache']['port'] = 80
default['myapache-cookbook']['name'] = 'John'
default['myapache-cookbook']['doc-root'] = '/var/www/html'
default['myapache-cookbook']['git-repo'] = 'https://github.com/alexpop/myapache-app'
default['myapache-cookbook']['git-revision'] = 'master'
