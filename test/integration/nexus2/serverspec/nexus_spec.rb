require 'serverspec'

set :backend, :exec

describe 'verify nexus' do

  describe file('/opt/sonatype-nexus/nexus/bin/nexus') do
    it { should be_file }
    it { should be_executable }
  end

  describe service('nexus') do
    it { should be_running }
  end

  describe port(8080) do
    it { should be_listening }
  end

end
