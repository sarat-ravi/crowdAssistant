require 'spec_helper'

describe "tasks/new" do
  before(:each) do
    assign(:task, stub_model(Task,
      :job_id => 1,
      :status => "MyString",
      :response => "MyString"
    ).as_new_record)
  end

  it "renders new task form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tasks_path, :method => "post" do
      assert_select "input#task_job_id", :name => "task[job_id]"
      assert_select "input#task_status", :name => "task[status]"
      assert_select "input#task_response", :name => "task[response]"
    end
  end
end
