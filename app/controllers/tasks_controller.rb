class TasksController < ApplicationController
  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = current_user.tasks.reverse
    

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = current_user.tasks.find(params[:id])
    @wolfram_results = nil;
    current_time = Time.now
    task_time = @task.created_at
    wolfram_timeout_period = 10*60

    images_timed_out = current_time > (task_time + wolfram_timeout_period)
    
    if Assistant.wolfram_succeeded_for(@task)
      @wolfram_results = images_timed_out ? WolframalphaApi.post_query(@task.instructions) : JSON.parse(@task.answer)
    end
    #TODO: delete the line below
    #Assistant.retrieve_task(@task)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = Task.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/1/edit
#  def edit
#    @task = current_user.tasks.find(params[:id])
#  end

  # POST /tasks
  # POST /tasks.json
  def create
    if params[:task][:instructions] == ""
      flash[:error] = "Please fill in a task"
      redirect_to "/", error: 'Please enter a task.' and return
    end
    if not current_user
      session[:instructions] = params[:task][:instructions]
      redirect_to "/auth/facebook" and return
    end
    session[:instructions] = nil
    @task = Task.new(:path => params[:path])
    if params[:path]
      path = DataFile.save(params)
      @task.path = path
    end
    @task.user_id = current_user.id
    @task.status = "Not Started"
    @task.answer = nil
    @task.instructions = params[:task][:instructions]
    @task.fields = params[:task][:fields]
    if @task.path
      @task.resource = request.host_with_port + "/" + @task.path
    else
      @task.resource = params[:task][:resource]
    end
    #these are more complicated tasks that can crash
    #if params are null, so if any problems, make them default
    begin
      @task.resourcetype = params[:task][:resourcetype][0].chr.swapcase
      prioritys = {"Low" => 1, "Medium" => 2, "High" => 3}
      @task.priority = prioritys[params[:task][:priority]]
      @task.workflow = params[:task][:workflow][0].chr.swapcase
      @task.redundancy = params[:task][:redundancy].to_i
    rescue
      @task.set_defaults_if_null()
    end

    @task.set_defaults_if_null

    respond_to do |format|
      if @task.save
        task_id = @task.id
        result = Assistant.handle(@task)
        if Assistant.wolfram_succeeded_for(@task) 
          flash[:notice] = "Task Completed by Wolfram"
          #This is seriously sketch. Assistant queries wolfram, 
          #if wolfram can answer, Assistant deletes @task completely,
          #and returns "wolfram" in Assistant.handle(task)
          #the query is sent in params hash to a result controller,
          #WHICH makes the result controller query wolfram AGAIN,
          #this time to actually display the results. 
          #NOTE: This implementation is just to debugg - will be changed later.
          #NOTE: This redirect is about to rape several tests
          #session[:wolfram_task_id] = task_id 
          #format.html { redirect_to '/result/index.html', notice: 'Wolfram can answer this question.' }
        end
        current_user.update_attributes(:balance => current_user.balance - 15)
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render json: @task, status: :created, location: @task }
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
#  def update
#    @task = current_user.tasks.find(params[:id])

#    respond_to do |format|
#      if @task.update_attributes(params[:task])
#        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
#        format.json { head :ok }
#      else
#        format.html { render action: "edit" }
#        format.json { render json: @task.errors, status: :unprocessable_entity }
#      end
#    end
#  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
#  def destroy
#    @task = current_user.tasks.find(params[:id])
#    @task.destroy

#    respond_to do |format|
#      format.html { redirect_to tasks_url }
#      format.json { head :ok }
#    end
#  end
end
