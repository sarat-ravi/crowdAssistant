class ProfilesController < ApplicationController
  # GET /profiles
  # GET /profiles.json
  def index
    @profile = current_user.profile
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @profiles }
    end
  end

  # GET /profiles/1/edit
  def edit
    @profile = current_user.profile
  end

  # PUT /profiles/1
  # PUT /profiles/1.json
  def update
    @profile = current_user.profile
    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        format.html { redirect_to profile_path, notice: 'Profile was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end
end
