require 'spec_helper'

describe "mobworkers/index" do
  before(:each) do
    assign(:mobworkers, [
      stub_model(Mobworker,
        :api_id => "Api",
        :assistant_id => 1,
        :rating => "Rating",
        :skill => "Skill"
      ),
      stub_model(Mobworker,
        :api_id => "Api",
        :assistant_id => 1,
        :rating => "Rating",
        :skill => "Skill"
      )
    ])
  end

  it "renders a list of mobworkers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Api".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Rating".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Skill".to_s, :count => 2
  end
end
