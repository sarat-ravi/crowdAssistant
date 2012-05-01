require 'spec_helper'
#require 'ActionDispatch'
describe DataFile do
	before(:each) do
		@user = User.create(:email => "john@gmail.com")
		@task = Task.create(:user_id => @user.id, :status => "Not started", :answer => [{"Response"=>"Answer"}], :mob_task_id=> "www.google.com")
		@task2 = Task.create(:user_id => @user.id, :status => "Completed", :answer => [{"Response"=>"Answer"}], :mob_task_id=>"www.google.com")
	end
	it "saves file to public folder if needed to upload" do
		f=File.new(Rails.root, 'r')
		x = ActionDispatch::Http::UploadedFile.new({@original_filename=>"photo.jpg", :tempfile=>f})
		upload = {'path'=>x}
		x.stub!(:original_filename).and_return("/text.txt")
		x.stub!(:read).and_return("This is the stuff in the text file")
		#File.should_receive(:write)
		File.stub!(:write).and_return(nil)
		File.stub!(:open).and_return(nil)
		#ActionDispatch::Http::UploadedFile.any_instance.stub(:original_filename).and_return("/test.txt")
		DataFile.save(upload)
	end
  	it "deletes file after task is completed" do
  		File.stub!(:delete).and_return(nil)
  		DataFile.delete("/public/test.txt")
  	end
end
