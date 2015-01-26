require 'serverspec'

set :backend, :exec

describe 'validate settings xml' do

  describe command('xmllint --noout /root/.m2/settings.xml') do
    its(:exit_status) { should eq 0 }
  end

end
