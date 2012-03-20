require 'spec_helper'

describe "assistants/index" do
  before(:each) do
    assign(:assistants, [
      stub_model(Assistant,
        :type => "Type"
      ),
      stub_model(Assistant,
        :type => "Type"
      )
    ])
  end

  it "renders a list of assistants" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Type".to_s, :count => 2
  end
end
