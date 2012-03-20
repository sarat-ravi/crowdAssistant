require 'spec_helper'

describe "mobworkers/show" do
  before(:each) do
    @mobworker = assign(:mobworker, stub_model(Mobworker,
      :api_id => "Api",
      :assistant_id => 1,
      :rating => "Rating",
      :skill => "Skill"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Api/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Rating/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Skill/)
  end
end
