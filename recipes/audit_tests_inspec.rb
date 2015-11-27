###
### BIG WORK IN PROGRESS ###
### THIS WILL ONLY WORK WHEN CHEF-CLIENT USES INSPEC INSTEAD OF SERVERSPEC
###

control_group 'Apache Audit' do
  control '01' do
    impact 0.7
    title 'Verify httpd service'
    desc 'Ensures httpd service is up and running'
    describe service('httpd') do
      it { should be_enabled }
      it { should be_installed }
      it { should be_running }
    end
  end

  # implement os dependent tests
  web_user = 'apache'
  web_user = 'httpd' if os[:family] == 'centos'

  control '02' do
    describe user(web_user) do
      it { should exist }
    end
  end
end
