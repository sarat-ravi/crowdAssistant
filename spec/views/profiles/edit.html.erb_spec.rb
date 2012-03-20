require 'spec_helper'

describe "profiles/edit" do
  before(:each) do
    @profile = assign(:profile, stub_model(Profile,
      :user_id => 1,
      :age => 1,
      :gender => "MyString",
      :pic_url => "MyString",
      :address => "MyString",
      :phonenum => "MyString"
    ))
  end

  it "renders the edit profile form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => profiles_path(@profile), :method => "post" do
      assert_select "input#profile_user_id", :name => "profile[user_id]"
      assert_select "input#profile_age", :name => "profile[age]"
      assert_select "input#profile_gender", :name => "profile[gender]"
      assert_select "input#profile_pic_url", :name => "profile[pic_url]"
      assert_select "input#profile_address", :name => "profile[address]"
      assert_select "input#profile_phonenum", :name => "profile[phonenum]"
    end
  end
end
