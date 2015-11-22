#
# Cookbook Name:: myapache-cookbook
# Recipe:: audit_tests
#

# TO-ADD
# System Requirements tests
# SSL days until expire check

# The only way node attributes can be used in tests
myplatform = node['platform']

control_group 'Apache Audit' do
  control 'httpd' do
    it 'should be installed' do
      expect(package('httpd')).to be_installed
    end

    it 'should be running' do
      expect(service('httpd')).to be_running
    end

    it 'should be enabled' do
      expect(service('httpd')).to be_enabled
    end

    it 'should be listening on port 80' do
      expect(port(80)).to be_listening
    end

    it 'does not allow directory listing' do
      expect(file('/etc/httpd/conf/httpd.conf').content).to_not match /^\s+Options.*[\+\s]Indexes/
    end
  end

  describe file('/etc/passwd') do
    it { should contain 'apache' }
  end

  describe command('apachectl -S') do
    its(:exit_status) { should eq 0 }
  end
end

control_group 'System Audit' do
  it 'Ports 22 & 111 should be listening' do
    expect(port(22)).to be_listening
    expect(port(111)).to be_listening
  end

  iptables_command = 'chkconfig --list iptables'
  describe command(iptables_command) do
    its(:stdout) { should_not match /^iptables.+:on/ }
  end

  describe file('/var/log/spooler') do
    it { should be_file }
  end

  it 'Platform should be centos' do
    expect(myplatform).to eq 'centos'
  end
end
