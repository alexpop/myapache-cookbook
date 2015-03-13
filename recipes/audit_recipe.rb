#
# Cookbook Name:: myapache-cookbook
# Recipe:: audit_recipe
#

log "*** In audit_recipe!"

control_group "Apache Audit" do

  control "httpd package" do
    it "should not be installed" do
      expect(package("httpd")).to_not be_installed
    end
  end
 
  describe port(80) do
    it { should be_listening }
  end

end
