#
# Cookbook Name:: myapache-cookbook
# Recipe:: audit_recipe
#

log "*** In audit_recipe!"

control_group "Apache Audit" do
  control "httpd" do
    it "should be installed" do
      expect(package("httpd")).to be_installed
    end

    it "should be running" do
      expect(service("ntpd")).to be_running
    end

    it "should be enabled" do
      expect(service("ntpd")).to be_enabled
    end
  end

  it "should be listening" do
    expect(port(80)).to be_listening
    expect(port(23)).to be_listening
  end

	describe file('/etc/passwd') do
    it { should contain 'apache' }
  end
 
  describe command('apachectl -S') do
    its(:stdout) { should match /^Syntax OK/ }
  end
end

control_group "System Audit" do
  iptables_command='chkconfig --list iptables'
  describe command(iptables_command) do
    its(:stdout) { should_not match /^iptables.+:on/ }
  end

  describe port(12345) do
    it { should be_listening }
  end
end




