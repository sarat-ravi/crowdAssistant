require 'spec_helper'

describe SessionsController do
  	describe "POST create" do
    	describe "with new connection" do
		    it "makes new user" do
		    	hash = {"provider"=>"facebook", "uid"=>123456789, "info" => {"name" => "John", "email"=>"john@gmail.com", "image"=>"www.fb.com/picture/type=square/"}}
				controller.stub!(:auth_hash).and_return(hash)
		        User.stub!(:find_by_provider_and_uid).and_return(nil)
		        u = User.create!
				User.stub!(:create_with_omniauth).with(hash).and_return(u)
		    	post :create, {:provider => "facebook"}
				session[:user_id].should eq(u.id)
				response.should redirect_to("/user")
      		end
    	end
    
    	describe "with an old connection" do
    		it "logs in with user" do
		    	hash = {"provider"=>"facebook", "uid"=>123456789, "info" => {"name" => "John", "email"=>"john@gmail.com", "image"=>"www.fb.com/picture/type=square/"}}
				controller.stub!(:auth_hash).and_return(hash)
				u = User.create!
		        User.stub!(:find_by_provider_and_uid).and_return(u)
				User.stub!(:create_with_omniauth).with(hash).and_return(u)

		    	post :create, {:provider => "facebook"}
				session[:user_id].should eq(u.id)
				response.should redirect_to("/user")
    		end
		end
	end
	describe "DELETE destroy" do
		it "signs out" do
			post :destroy
			session[:user_id].should eq(nil)
			response.should redirect_to("/")
		end
	end
end