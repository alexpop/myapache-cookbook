name 'myapache-cookbook'
maintainer 'Alex Pop'
maintainer_email 'alex@example.com'
license 'All rights reserved'
description 'Installs/Configures myapache-cookbook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version  '0.1.10'

recipe 'myapache-cookbook::default', 'Default recipe to install Apache'
