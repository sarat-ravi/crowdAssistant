require 'spec_helper'

describe "assistants/new" do
  before(:each) do
    assign(:assistant, stub_model(Assistant,
      :type => ""
    ).as_new_record)
  end

  it "renders new assistant form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => assistants_path, :method => "post" do
      assert_select "input#assistant_type", :name => "assistant[type]"
    end
  end
end
