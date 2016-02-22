# use basic tests
describe package('httpd') do
  it { should be_installed }
end

# extend tests with metadata
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
web_user = 'www-data'
web_user = 'apache' if os[:family] == 'centos'

describe user(web_user) do
  it { should exist }
end
