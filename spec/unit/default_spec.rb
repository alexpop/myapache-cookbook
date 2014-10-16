require_relative '../spec_helper.rb'

describe 'myapache-cookbook::default' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it 'creates an index page correctly' do
    expect(chef_run).to create_template('/var/www/index.html').with(
      mode: '0644'
    )
  end
end
