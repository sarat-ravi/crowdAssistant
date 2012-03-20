require 'spec_helper'

describe "assistants/edit" do
  before(:each) do
    @assistant = assign(:assistant, stub_model(Assistant,
      :type => ""
    ))
  end

  it "renders the edit assistant form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => assistants_path(@assistant), :method => "post" do
      assert_select "input#assistant_type", :name => "assistant[type]"
    end
  end
end
