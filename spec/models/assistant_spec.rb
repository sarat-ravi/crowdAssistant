require 'spec_helper'

describe Assistant do
	before(:each) do
		@task = Task.create(:status => "Not started", :answer => [{"Response"=>"Answer"}], :mob_task_id=> "www.google.com")
		@task2 = Task.create(:status => "Completed", :answer => [{"Response"=>"Answer"}], :mob_task_id=>"www.google.com")
	end
	it "handles task" do
		Assistant.stub!(:execute_task).with(@task).and_return(nil)
		Assistant.should_receive(:handle).with(@task)
		Assistant.handle(@task)
	end
	it "executes task" do
		hash = {}
		hash["Location"] = "https://works.mobileworks.com/api/v2/tasks/1/"
		MobileworksApi.stub!(:post_task).with(@task).and_return(hash)
		Assistant.execute_task(@task)
		Task.find_by_id(@task.id).mob_task_id.should eq("https://works.mobileworks.com/api/v2/tasks/1/")
	end
	it "retreives task" do
		hash = {}
		hash["status"] = "Completed"
		hash["answer"] = [{"Response"=>"Answer"}]
		MobileworksApi.stub!(:retrieve_task).with(@task).and_return(hash)
		Assistant.retrieve_task(@task)
		Task.find_by_id(@task.id).status.should eq("Completed")
		Task.find_by_id(@task.id).answer.should eq("Response: Answer.")
	end
end