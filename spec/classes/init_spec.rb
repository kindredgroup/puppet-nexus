require 'spec_helper'
describe 'nexus' do

  context 'with defaults for all parameters' do
    it { should compile.with_all_deps }

    it "should not contain changes in wrapper.conf" do
      should_not contain_file_line('nexus_initmemory')
      should_not contain_file_line('nexus_maxmemory')
      should_not contain_file_line('nexus_permgen')
      should_not contain_file_line('nexus_javacommand')
    end

  end

  context 'with plugin yum' do
    let (:params) do {
      :plugins => [ 'yum' ]
    } end

    it {
      should contain_class('nexus::plugin::yum')
    }

    it { should compile.with_all_deps }

  end

  context 'teardown' do
    let (:params) do {
      :ensure => 'absent'
    } end

    it { should compile.with_all_deps }
  end

  context 'with jvm settings' do
    let (:params) do {
      :initmemory => 1234
    } end

    it {
      should contain_file_line('nexus_initmemory').with(
        :line => 'wrapper.java.initmemory=1234'
      )
    }
  end

  context 'with nexus version 3' do
    let (:params) do
      {
        :version => '3.0.0-03',
        :initmemory => '1234M'
      }
    end

    it { should compile.with_all_deps }
    it { should contain_file_line('nexus_initmemory').with_line('-Xms1234M') }

  end
end
