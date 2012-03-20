class AssistantsController < ApplicationController
  # GET /assistants
  # GET /assistants.json
  def index
    @assistants = Assistant.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @assistants }
    end
  end

  # GET /assistants/1
  # GET /assistants/1.json
  def show
    @assistant = Assistant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @assistant }
    end
  end

  # GET /assistants/new
  # GET /assistants/new.json
  def new
    @assistant = Assistant.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @assistant }
    end
  end

  # GET /assistants/1/edit
  def edit
    @assistant = Assistant.find(params[:id])
  end

  # POST /assistants
  # POST /assistants.json
  def create
    @assistant = Assistant.new(params[:assistant])

    respond_to do |format|
      if @assistant.save
        format.html { redirect_to @assistant, notice: 'Assistant was successfully created.' }
        format.json { render json: @assistant, status: :created, location: @assistant }
      else
        format.html { render action: "new" }
        format.json { render json: @assistant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /assistants/1
  # PUT /assistants/1.json
  def update
    @assistant = Assistant.find(params[:id])

    respond_to do |format|
      if @assistant.update_attributes(params[:assistant])
        format.html { redirect_to @assistant, notice: 'Assistant was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @assistant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assistants/1
  # DELETE /assistants/1.json
  def destroy
    @assistant = Assistant.find(params[:id])
    @assistant.destroy

    respond_to do |format|
      format.html { redirect_to assistants_url }
      format.json { head :ok }
    end
  end
end
