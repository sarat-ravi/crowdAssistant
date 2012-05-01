require 'spec_helper'

describe Assistant do
	before(:each) do
		@user = User.create(:email => "john@gmail.com")
		@task = Task.create(:user_id => @user.id, :status => "Not started", :answer => [{"Response"=>"Answer"}], :mob_task_id=> "www.google.com")
		@task2 = Task.create(:user_id => @user.id, :status => "Completed", :answer => [{"Response"=>"Answer"}], :mob_task_id=>"www.google.com")
		@task3 = Task.create(:mob_task_id => "wolfram")
	end
	it "handles task" do
		Assistant.stub!(:execute_task).with(@task).and_return(nil)
		Assistant.stub!(:ask_wolfram).with(@task).and_return(nil)
		Assistant.should_receive(:handle).with(@task)
		Assistant.handle(@task)
	end
  it "should execute task if wolfram failed" do
		Assistant.stub!(:ask_wolfram).with(@task).and_return(nil)
		Assistant.should_receive(:execute_task).with(@task)
		Assistant.handle(@task)
  end
  it "should not execute task if wolfram succeeded" do
		Assistant.stub!(:ask_wolfram).with(@task).and_return(["<queryresult>results</queryresult>"])
		Assistant.should_not_receive(:execute_task)
		Assistant.handle(@task)
  end
	it "executes task" do
		hash = {}
		hash["Location"] = "https://works.mobileworks.com/api/v2/tasks/1/"
		MobileworksApi.stub!(:post_task).with(@task).and_return(hash)
		Assistant.execute_task(@task)
		Task.find_by_id(@task.id).mob_task_id.should eq("https://works.mobileworks.com/api/v2/tasks/1/")
	end
  it "updates task status" do
		Assistant.stub!(:wolfram_succeeded_for).with(@task).and_return(false)
		Assistant.stub!(:retrieve_task).with(@task).and_return(nil)
		Assistant.should_receive(:update_status_for).with(@task)
		Assistant.update_status_for(@task)
  end
  it "should retrieve task from mobileworks if wolfram failed" do
		Assistant.stub!(:wolfram_succeeded_for).with(@task).and_return(false)
		Assistant.stub!(:retrieve_task).with(@task).and_return(nil)
		Assistant.should_receive(:retrieve_task)
		Assistant.update_status_for(@task)
  end
  it "should not retrieve task from mobileworks if wolfram succeeded" do
		Assistant.stub!(:wolfram_succeeded_for).with(@task).and_return(true)
		Assistant.stub!(:retrieve_task).with(@task).and_return(nil)
		Assistant.should_receive(:update_status_for).with(@task)
		Assistant.should_not_receive(:retrieve_task)
		Assistant.update_status_for(@task)
  end
	it "retreives task if response is new" do
		hash = {}
		hash["status"] = "Completed"
		hash["answer"] = [{"Response"=>"Answer"}]
		MobileworksApi.stub!(:retrieve_task).with(@task).and_return(hash)
		Assistant.retrieve_task(@task)
		Task.find_by_id(@task.id).status.should eq("Completed")
		Task.find_by_id(@task.id).answer.should eq("Response: Answer.")
	end
	it "retreives task if response is same" do
		hash = {}
		hash["status"] = "Completed"
		hash["answer"] = "Answer"
		MobileworksApi.stub!(:retrieve_task).with(@task).and_return(hash)
		Assistant.retrieve_task(@task)
		Task.find_by_id(@task.id).status.should eq("Completed")
		Task.find_by_id(@task.id).answer.should eq("Answer")
	end
	it "updates all tasks" do
		Task.stub!(:find).and_return([@task])
		Assistant.stub!(:retrieve_task).and_return(true)
		Assistant.should_receive(:retrieve_task).with(@task).and_return(true)
		Assistant.update_all
	end
	it 'checks mobtask id for wolfram' do
		Assistant.wolfram_succeeded_for(@task).should == false
	end
	it 'checks mobtask id for wolfram' do
		Assistant.wolfram_succeeded_for(@task3).should == true
	end
	it 'asks wolfram' do
		WolframalphaApi.stub!(:post_query).with(@task.instructions).and_return("Results")
		Assistant.ask_wolfram(@task).should == "Results"
	end
end
