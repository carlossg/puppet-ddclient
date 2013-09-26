require 'spec_helper'

describe 'ddclient' do

  let(:params) {{
    :login  => 'johndoe@gmail.com',
    :password  => 'mypassword',
    :host => 'acme.dnsdynamic.com'
  }}

  it { should contain_service('ddclient').with_ensure('running') }

end
