require 'spec_helper'

describe "jobs/new" do
  before(:each) do
    assign(:job, stub_model(Job,
      :user_id => 1,
      :assistant_id => 1
    ).as_new_record)
  end

  it "renders new job form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => jobs_path, :method => "post" do
      assert_select "input#job_user_id", :name => "job[user_id]"
      assert_select "input#job_assistant_id", :name => "job[assistant_id]"
    end
  end
end
