require 'spec_helper'

describe "home/index" do
  before(:each) do
    assign(:home, [
      stub_model(Home),
      stub_model(Home)
    ])
  end
end
