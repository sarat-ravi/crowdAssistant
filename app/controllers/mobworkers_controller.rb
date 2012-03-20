class MobworkersController < ApplicationController
  # GET /mobworkers
  # GET /mobworkers.json
  def index
    @mobworkers = Mobworker.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mobworkers }
    end
  end

  # GET /mobworkers/1
  # GET /mobworkers/1.json
  def show
    @mobworker = Mobworker.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mobworker }
    end
  end

  # GET /mobworkers/new
  # GET /mobworkers/new.json
  def new
    @mobworker = Mobworker.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mobworker }
    end
  end

  # GET /mobworkers/1/edit
  def edit
    @mobworker = Mobworker.find(params[:id])
  end

  # POST /mobworkers
  # POST /mobworkers.json
  def create
    @mobworker = Mobworker.new(params[:mobworker])

    respond_to do |format|
      if @mobworker.save
        format.html { redirect_to @mobworker, notice: 'Mobworker was successfully created.' }
        format.json { render json: @mobworker, status: :created, location: @mobworker }
      else
        format.html { render action: "new" }
        format.json { render json: @mobworker.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mobworkers/1
  # PUT /mobworkers/1.json
  def update
    @mobworker = Mobworker.find(params[:id])

    respond_to do |format|
      if @mobworker.update_attributes(params[:mobworker])
        format.html { redirect_to @mobworker, notice: 'Mobworker was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @mobworker.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mobworkers/1
  # DELETE /mobworkers/1.json
  def destroy
    @mobworker = Mobworker.find(params[:id])
    @mobworker.destroy

    respond_to do |format|
      format.html { redirect_to mobworkers_url }
      format.json { head :ok }
    end
  end
end
