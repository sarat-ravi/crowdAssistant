require 'spec_helper'
require 'mobileworks_api'
require 'json'
#require File.expand_path(File.dirname(__FILE__) + '/../spec_helper') 

describe MobileworksApi do

  describe "#post_task" do
    it "should post the task and return task uri" do

      @@taskUri = "http://work.mobileworks.com/api/v2/task/168326/" 
      taskUriJson = '{"Location":"' + @@taskUri + '"}'
      MobileworksApi.stub(:get_response).and_return(taskUriJson)

      task = mock('task',:redundancy=>2,:priority=>1, :workflow=>"p",:resourcetype=>"link", :instructions=>"How to write rpsec tests for files in lib dir", :fields=>[{:name=>"t"}], :resource=>"http://www.mobileworks.com/developers/images/samplecard.jpg")
      hash_response = MobileworksApi.post_task(task)

      task_uri = hash_response["Location"]


      task_uri.should == @@taskUri


    end

    #it "should raise exception if malformed param" do
    #  lambda{MobileworksApi.post_task("I am an invalid parameter")}.should raise_error(ArgumentError)
    #end

  end

  describe "#retrieve_task" do
    it "should retrieve the task given by task uri" do
      @@taskUri = @@taskUri.gsub("http:","https:") 
      MobileworksApi.should_receive(:retrieve_task).with(@@taskUri).and_return(hash_including(:answer=>anything(),
                                                                                              :confidence=>anything(),
                                                                                              :status=>anything(),
                                                                                              :instructions=>anything(),
                                                                                              :redundancy=>anything(),
                                                                                              :workflow=>anything(),
                                                                                              :resource=>anything(),
                                                                                              :resourcetype=>anything(),
                                                                                              :resource=>anything(),
                                                                                              :resourcetype=>anything(),
                                                                                              :resource_url=>anything(),
                                                                                              :timeCreated=>anything(),
                                                                                              :timeFinished=>anything()))
      response_hash = MobileworksApi.retrieve_task(@@taskUri)

    end
  end

end