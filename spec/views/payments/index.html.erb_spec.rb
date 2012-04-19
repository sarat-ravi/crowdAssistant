require 'spec_helper'

describe "payments/index" do
  before(:each) do
    assign(:payments, [
      stub_model(Payment),
      stub_model(Payment)
    ])
  end

  it "renders a list of payments" do
    render
  end
end
