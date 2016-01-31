require 'spec_helper'
describe 'icvpn' do

  context 'with defaults for all parameters' do
    it { should contain_class('icvpn') }
  end
end
