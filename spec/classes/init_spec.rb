require 'spec_helper'
describe 'nexus' do

  context 'with defaults for all parameters' do
    it { should compile.with_all_deps }
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
end
