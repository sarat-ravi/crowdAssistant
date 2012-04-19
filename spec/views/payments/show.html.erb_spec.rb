require 'spec_helper'

describe "payments/show" do
  before(:each) do
    @payment = assign(:payment, stub_model(Payment))
  end

  it "renders attributes in <p>" do
    render
  end
end
