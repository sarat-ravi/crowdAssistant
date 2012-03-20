require 'spec_helper'

describe "mobworkers/new" do
  before(:each) do
    assign(:mobworker, stub_model(Mobworker,
      :api_id => "MyString",
      :assistant_id => 1,
      :rating => "MyString",
      :skill => "MyString"
    ).as_new_record)
  end

  it "renders new mobworker form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => mobworkers_path, :method => "post" do
      assert_select "input#mobworker_api_id", :name => "mobworker[api_id]"
      assert_select "input#mobworker_assistant_id", :name => "mobworker[assistant_id]"
      assert_select "input#mobworker_rating", :name => "mobworker[rating]"
      assert_select "input#mobworker_skill", :name => "mobworker[skill]"
    end
  end
end
