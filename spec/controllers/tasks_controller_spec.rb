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
    controller.stub!(:current_user).and_return(@user)
  end

  describe "GET index" do
    it "assigns all tasks as @tasks" do
      get :index, {}, valid_session
      assigns(:tasks).should eq(@tasks)
    end
  end

  describe "GET show" do
    it "assigns the requested task as @task" do
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
    describe "with valid params" do
      it "creates a new Task" do
        #a = Assistant.new
        Assistant.any_instance.stub(:handle).and_return(nil)
        expect {
          post :create, {:task => {:instructions => "instr", :fields=>'[{"Answer":"t"}]', :resource => "www.google.com", :resourcetype => "Link", :workflow => "Parallel", :redundancy => "2"}}, valid_session
        }.to change(Task, :count).by(1)
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

    describe "with invalid params" do
      it "assigns a newly created but unsaved task as @task" do
        Assistant.any_instance.stub(:handle).and_return(nil)

        # Trigger the behavior that occurs when invalid params are submitted
        Task.any_instance.stub(:save).and_return(false)
        post :create, {:task => {:resourcetype => "Link", :workflow => "Parallel", :redundancy => "2"}}, valid_session
        assigns(:task).should be_a_new(Task)
      end

      it "re-renders the 'new' template" do
        Assistant.any_instance.stub(:handle).and_return(nil)

        # Trigger the behavior that occurs when invalid params are submitted
        Task.any_instance.stub(:save).and_return(false)
        post :create, {:task => {:resourcetype => "Link", :workflow => "Parallel", :redundancy => "2"}}, valid_session
        response.should render_template("new")
      end
    end
  end
end
