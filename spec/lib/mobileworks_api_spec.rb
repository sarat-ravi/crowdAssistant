require 'spec_helper'
require 'mobileworks_api'
require 'json'

describe MobileworksApi do

  before(:each) do
    @task = Task.create(:mob_task_id => "http://work.mobileworks.com/api/v2/task/1/",:redundancy=>2,:priority=>1, :workflow=>"p",:resourcetype=>"link", :instructions=>"How to write rpsec tests for files in lib dir", :fields=>[{:name=>"t"}], :resource=>"http://www.mobileworks.com/developers/images/samplecard.jpg")
  end

  describe "#post_task" do
    it "should post the task and return task uri" do

      taskUri = "http://work.mobileworks.com/api/v2/task/1/" 
      taskUriJson = '{"Location":"' + taskUri + '"}'
      MobileworksApi.stub(:get_response).and_return(taskUriJson)

      hash_response = MobileworksApi.post_task(@task)

      task_uri = hash_response["Location"]


      task_uri.should == taskUri


    end

    #it "should raise exception if malformed param" do
    #  lambda{MobileworksApi.post_task("I am an invalid parameter")}.should raise_error(ArgumentError)
    #end

  end

  describe "#retrieve_task" do
    it "should retrieve the task given by task uri" do
      resp = '{"answer":"ans","confidence":"conf","status":"stat","instructions":"inst","redundancy":"red","workflow":"work",
                                                                                                          "resource":"res",
                                                                                                          "resourcetype":"rtype",
                                                                                                          "resource_url":"rurl",
                                                                                                          "timeCreated":"tcreated",
                                                                                                          "timeFinished":"tfinished"}'
      MobileworksApi.stub(:get_response).and_return(resp)
      @task.mob_task_id = @task.mob_task_id.gsub("http:", "https:")
      @task.save!
      response_hash = MobileworksApi.retrieve_task(@task)
      response_hash.class.should eq(Hash)

    end
  end

  describe "#get_response" do
    it "should execute the request in the server" do
      cmd = "https://work.mobileworks.com/api/v2/task/1/ -u Sarat:Tallamraju"
      resp = {}
      resp["Login"] = "Bad username or password"
      resp["Login"].should eq(JSON.parse(MobileworksApi.get_response(cmd))["Login"])
    end
  end
end