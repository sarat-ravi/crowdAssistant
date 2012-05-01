require 'spec_helper'

describe Task do
	before(:each) do
		@task = Task.create!
	end
	it "checks not set" do
		Task.not_set(nil).should == true
	end
	it "checks not set" do
		Task.not_set(true).should == false
	end
	it "sets default if null" do
		Task.stub!(:not_set).and_return(true)
		@task.set_defaults_if_null()
		@task.priority.should == 2
		@task.workflow.should == "p"
		@task.redundancy.should == 2
	end
	it "sets default" do
		@task.set_defaults()
		@task.priority.should == 2
		@task.workflow.should == "p"
		@task.redundancy.should == 2
	end

end
