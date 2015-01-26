require 'serverspec'

set :backend, :exec

describe 'verify maven' do

  describe file('/opt/apache-maven-3.1.1/bin/mvn') do
    it { should be_file }
    it { should be_executable }
  end

  describe command('/opt/apache-maven-3.1.1/bin/mvn archetype:generate -DinteractiveMode=false -DgroupId=someGroup -DartifactId=someArtifact -Dpackage=somePackage') do
    its(:exit_status) { should eq 0 }
  end

end
