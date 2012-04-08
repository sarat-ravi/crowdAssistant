require 'spec_helper'

describe User do

  it 'Should use auth input properly' do

    a=mock('auth')

    b=mock('array')
    b.should_receive('[]').with("name")
    b.should_receive('[]').with("email")

    a.stub('[]').and_return(b)


    a.should_receive('[]').with("provider")
    a.should_receive('[]').with("uid")
    a.should_receive('[]').with("info")
    a.should_receive('[]').with("info")
    User.create_with_omniauth(a)
  end


end
