require_relative '../spec_helper.rb'

describe 'myapache-cookbook::default' do
  let(:chef_run) { ChefSpec::ServerRunner.converge(described_recipe) }

  it 'Does not raise an error' do
    expect { chef_run }.not_to raise_error
  end

  it 'Installs package tree' do
    expect(chef_run).to install_package 'tree'
  end

  it 'Installs/Upgrades the httpd package' do
    expect(chef_run).to upgrade_package 'httpd'
  end
end

describe 'sample 1 plus 1 rspec' do
  it 'equals 2' do
    a = 1
    b = 1
    sum = a + b
    expect(sum).to eq(2)
    expect(sum).not_to eq(3)
  end
end
