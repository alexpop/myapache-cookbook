name 'myapache-cookbook'
maintainer 'Alex Pop'
maintainer_email 'alex@example.com'
license 'All rights reserved'
description 'Installs/Configures myapache-cookbook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.10.13'

recipe 'myapache-cookbook::default', 'Default recipe to install Apache'
recipe 'myapache-cookbook::app_checkout', 'Default recipe to deploy public git code'
recipe 'myapache-cookbook::ssl', 'Deploy SSL cert from data bag'
recipe 'myapache-cookbook::sandbox', 'Playing with fire'

depends 'git'
depends 'httpd'

%w(redhat centos fedora oracle).each do |os|
  supports os
end
