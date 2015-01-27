require 'puppetlabs_spec_helper/module_spec_helper'

RSpec.configure do |c|
  c.before do
    # avoid "Only root can execute commands as other users"
    Puppet.features.stubs(:root? => true)
  end
  c.default_facts = {
    :osfamily                   => 'RedHat',
    :operatingsystem            => 'RedHat',
    :operatingsystemmajrelease  => '6',
    :operatingsystemminrelease  => '5',
    :operatingsystemrelease     => '6.5',
  }
end

at_exit { RSpec::Puppet::Coverage.report! }
