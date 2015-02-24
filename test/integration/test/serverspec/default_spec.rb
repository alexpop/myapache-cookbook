require 'serverspec'

set :backend, :exec

# Just one test here, more examples in the 'dev' tests 

describe port(80) do
  it { should be_listening }
end

