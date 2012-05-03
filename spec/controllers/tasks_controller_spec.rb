require 'spec_helper'

describe TasksController do
  
  def valid_session
    {}
  end
  
  before(:each) do
    @user = User.create!
    @tasks = @user.tasks << Task.create!
    @tasks = @user.tasks << Task.create!
    @task = @user.tasks.first
    @task.created_at = Time.now + 86400
    @task.save!
    @task2 = Task.last
    controller.stub!(:current_user).and_return(@user)
  end

  describe "GET index" do
    it "assigns all tasks as @tasks" do
      get :index, {}, valid_session
      assigns(:tasks).should eq(@tasks.reverse!)
    end
  end

  describe "GET show" do
    it "assigns the requested task as @task" do
      get :show, {:id => @task.to_param}, valid_session
      assigns(:task).should eq(@task)
    end
  end

  describe "GET show" do
    it "enters the if loop" do
      Assistant.stub!(:wolfram_succeeded_for).and_return(true)
      WolframalphaApi.stub!(:post_query).and_return(true)
      JSON.stub!(:parse).and_return(true)
      get :show, {:id => @task2.to_param}, valid_session
      assigns(:task).should eq(@task2)
    end
    it "enters the if loop and goes to second one" do
      Assistant.stub!(:wolfram_succeeded_for).and_return(true)
      WolframalphaApi.stub!(:post_query).and_return(true)
      JSON.stub!(:parse).and_return(true)
      get :show, {:id => @task.to_param}, valid_session
      assigns(:task).should eq(@task)
    end
  end

  describe "GET new" do
    it "assigns a new task as @task" do
      get :new, {}, valid_session
      assigns(:task).should be_a_new(Task)
    end
  end

  describe "POST create" do
    before(:each) do
      taskUri = "https://work.mobileworks.com/api/v2/task/1/" 
      taskUriJson = '{"Location":"' + taskUri + '"}'
      MobileworksApi.stub!(:get_response).and_return(taskUriJson)
      Assistant.stub!(:handle).and_return(nil)
    end
    describe "with valid params" do
      it "creates a new Task" do
        #a = Assistant.new

        Assistant.any_instance.stub(:handle).and_return(nil)
        expect {
          post :create, {:task => {:instructions => "instr", :fields=>'[{"Answer":"t"}]', :resource => "www.google.com", :resourcetype => "Link", :workflow => "Parallel", :redundancy => "2"}}, valid_session
        }.to change(Task, :count).by(1)
      end

      it "redirects to the home on emtpy" do
        #Assistant.any_instance.stub(:handle).and_return(nil)
        post :create, {:task => {:instructions => "", :fields=>'[{"Answer":"t"}]', :resource => "www.google.com", :resourcetype => "Link", :workflow => "Parallel", :redundancy => "2"}}, valid_session
        response.should redirect_to("/")
      end

      it 'redirects to auth if not signed in' do
        controller.stub!(:current_user).and_return(nil)
        post :create, {:task => {:instructions => "", :fields=>'[{"Answer":"t"}]', :resource => "www.google.com", :resourcetype => "Link", :workflow => "Parallel", :redundancy => "2"}}, valid_session
        #response.should redirect_to("/auth/facebook")
        response.should redirect_to("/")
      end

      it "sets the path properly" do
        Assistant.any_instance.stub(:handle).and_return(nil)
        DataFile.stub!(:save).and_return("/image.txt")
        #post :create, {:task => {:resourcetype => "Link", :workflow => "Parallel", :redundancy => "2"}}, valid_session
        post :create, {:path=>"/image.txt", :task => { :instructions => "instr", :fields=>'[{"Answer":"t"}]', :resource => "www.google.com", :resourcetype => "Link", :workflow => "Parallel", :redundancy => "2"}}, valid_session
        assigns(:task).should be_a(Task)
        assigns(:task).should be_persisted
      end


      it "assigns a newly created task as @task" do
        Assistant.any_instance.stub(:handle).and_return(nil)

        #post :create, {:task => {:resourcetype => "Link", :workflow => "Parallel", :redundancy => "2"}}, valid_session
        post :create, {:task => {:instructions => "instr", :fields=>'[{"Answer":"t"}]', :resource => "www.google.com", :resourcetype => "Link", :workflow => "Parallel", :redundancy => "2"}}, valid_session
        assigns(:task).should be_a(Task)
        assigns(:task).should be_persisted
      end

      it "redirects to the created task" do
        Assistant.any_instance.stub(:handle).and_return(nil)

        #post :create, {:task => {:resourcetype => "Link", :workflow => "Parallel", :redundancy => "2"}}, valid_session
        post :create, {:task => {:instructions => "instr", :fields=>'[{"Answer":"t"}]', :resource => "www.google.com", :resourcetype => "Link", :workflow => "Parallel", :redundancy => "2"}}, valid_session
        response.should redirect_to(Task.last)
      end
    end
  end
end
