require 'serverspec'

set :backend, :exec

describe package('httpd'), if: os[:family] == 'redhat' do
  it { should be_installed }
end

#describe package('tree') do
#  it { should be_installed }
#end

describe service('httpd'), if: os[:family] == 'redhat' do
  it { should be_enabled }
  it { should be_running }
end

describe port(80) do
  it { should be_listening }
end

describe command('apachectl -S') do
  its(:stdout) { should match /^Syntax OK/ }
end

describe command('chkconfig --list iptables') do
  its(:stdout) { should_not match /^iptables.+:on/ }
end

describe service('iptables') do
  it { should_not be_enabled }
  it { should_not be_running }
end


