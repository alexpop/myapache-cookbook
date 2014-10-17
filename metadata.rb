name 'myapache-cookbook'
maintainer 'Alex Pop'
maintainer_email 'alex@example.com'
license 'All rights reserved'
description 'Installs/Configures myapache-cookbook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.2.10'

recipe 'myapache-cookbook::default', 'Default recipe to install Apache'
recipe 'myapache-cookbook::app-checkout', 'Default recipe to deploy public git code'
