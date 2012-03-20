require 'spec_helper'

describe "profiles/new" do
  before(:each) do
    assign(:profile, stub_model(Profile,
      :user_id => 1,
      :age => 1,
      :gender => "MyString",
      :pic_url => "MyString",
      :address => "MyString",
      :phonenum => "MyString"
    ).as_new_record)
  end

  it "renders new profile form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => profiles_path, :method => "post" do
      assert_select "input#profile_user_id", :name => "profile[user_id]"
      assert_select "input#profile_age", :name => "profile[age]"
      assert_select "input#profile_gender", :name => "profile[gender]"
      assert_select "input#profile_pic_url", :name => "profile[pic_url]"
      assert_select "input#profile_address", :name => "profile[address]"
      assert_select "input#profile_phonenum", :name => "profile[phonenum]"
    end
  end
end
