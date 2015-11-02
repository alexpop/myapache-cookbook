# doing something
file '/tmp/something' do
  punter 'root'
  action :create
end

package "rubo" do
  action :install
end
