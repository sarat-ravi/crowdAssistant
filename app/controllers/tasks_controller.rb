class TasksController < ApplicationController
  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = current_user.tasks

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = current_user.tasks.find(params[:id])

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

    @task = Task.new(params[:task])
    @task.user_id = current_user.id
    @task.status = "Not Started"
    @task.answer = nil
    @task.resource = params[:task][:resource]
    @task.resourcetype = params[:task][:resourcetype][0].chr.swapcase
    prioritys = {"Low" => 1, "Medium" => 2, "High" => 3}
    @task.priority = prioritys[params[:task][:priority]]
    @task.workflow = params[:task][:workflow][0].chr.swapcase
    @task.redundancy = params[:task][:redundancy].to_i
    @task.instructions = params[:task][:instructions]
    @task.fields = params[:task][:fields]

    respond_to do |format|
      if @task.save
        Assistant.handle(@task)
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
