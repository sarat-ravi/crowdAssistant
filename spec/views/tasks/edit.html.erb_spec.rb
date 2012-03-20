require 'spec_helper'

describe "tasks/edit" do
  before(:each) do
    @task = assign(:task, stub_model(Task,
      :job_id => 1,
      :status => "MyString",
      :response => "MyString"
    ))
  end

  it "renders the edit task form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tasks_path(@task), :method => "post" do
      assert_select "input#task_job_id", :name => "task[job_id]"
      assert_select "input#task_status", :name => "task[status]"
      assert_select "input#task_response", :name => "task[response]"
    end
  end
end
