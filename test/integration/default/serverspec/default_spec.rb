require 'serverspec'

set :backend, :exec

describe package('httpd'), if: os[:family] == 'redhat' do
  it { should be_installed }
end

describe package('tree') do
  it { should be_installed }
end

describe service('httpd'), if: os[:family] == 'redhat' do
  it { should be_enabled }
  it { should be_running }
end

describe port(80) do
  it { should be_listening }
end

describe port(443) do
  it { should be_listening }
end

describe command('apachectl -S') do
  its(:stdout) { should match /^Syntax OK/ }
end

iptables_command='chkconfig --list iptables'
describe command(iptables_command) do
  its(:stdout) { should_not match /^iptables.+:on/ }
end

describe service('iptables') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe file('/etc/passwd') do
  it { should contain 'apache' }
end

describe 'File checks' do
  let :pass_file do
    file('/etc/passwd')
  end
	it { expect(pass_file).to be_a_file }
  it { expect(pass_file.content).to match /vagrant/ }

	it 'it contains root' do
    expect(pass_file.content).to match /root/
  end
end

@commands = [{ 'to_run' => "cat /etc/passwd", 
               'to_expect' => /^apache.+nologin$/ },
             { 'to_run' => "cat /etc/passwd", 
               'to_expect' => /^vagrant.+bash$/ },
             { 'to_run' => "ifconfig", 
               'to_expect' => /^eth1.+Ethernet/ }]

@commands.each do |c|
  describe command(c['to_run']) do
    its(:stdout) { should match c['to_expect'] }
  end
end

#oracle_command='echo "select 1 from dual;" | sqlplus / as sysdba'
#describe command(oracle_command) do
#  its(:stdout) { should match /^1 rows selected\./ }
#end

