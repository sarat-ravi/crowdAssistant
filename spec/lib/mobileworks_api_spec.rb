require 'spec_helper'
#require File.expand_path(File.dirname(__FILE__) + '/../spec_helper') 

describe MobileworksApi do
  
  describe "#post_task" do
    it "should post the task and return task uri" do
      
      @api = MobileWorks.new
      MobileWorks.should_receive(:get_response).with(anything()).and_return("http://work.mobileworks.com/api/v2/task/168308/")

      @task_uri = @api.post_task("instructions lol", "fields lol")
      

    end

  end



end
