class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @user = current_user
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user }
    end
  end

end
