# doing something
file '/tmp/something' do
  punter 'root'
  action :create
end

package 'httpd' do
  version "2.3.9"
  action :install
end
