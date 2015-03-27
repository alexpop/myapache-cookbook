#
# Cookbook Name:: myapache-cookbook
# Recipe:: audit_recipe
#

log "*** In audit_recipe!"

control_group "Apache Audit" do
  describe file('/etc/passwd') do
    it { should contain 'apache' }
  end

  control "httpd package" do
    it "should be installed" do
      expect(package("httpd")).to be_installed
    end
  end
 
  describe command('apachectl -S') do
    its(:stdout) { should match /^Syntax OK/ }
  end

  describe port(80) do
    it { should be_listening }
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




