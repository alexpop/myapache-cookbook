# myapache-cookbook::basic_auth recipe

# Raise error if the attributes are not defined
%w( auth_user auth_pass_hash ).each do |attr|
  unless node['myapache-cookbook'][attr].is_a?(String)
    Chef::Log.fatal("*** You did not set the node['myapache-cookbook'][#{attr}] value!")
    raise
  end
end

template "/etc/httpd/.htpasswd" do
  source "htpasswd.erb"
  mode "0400"
  variables(
    :auth_user => node['myapache-cookbook']['auth_user'],
    :auth_pass_hash => node['myapache-cookbook']['auth_pass_hash']
  )
end
