require 'spec_helper'

describe "assistants/show" do
  before(:each) do
    @assistant = assign(:assistant, stub_model(Assistant,
      :type => "Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Type/)
  end
end
