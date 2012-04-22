require 'spec_helper'
require 'stripe'
describe PaymentsController do

  before(:each) do
    @user = User.create!
    controller.stub!(:current_user).and_return(@user)
  end
  describe "GET index" do
    it "renders payment index" do
      get :index, {}
      response.should render_template("index")
    end
  end

  describe "POST create" do
    before(:each) do
      Stripe::Charge.stub!(:create).and_return({"created" => 12345})
    end
    describe "with valid params" do
      it "creates a new Payment" do
        expect {
          post :create, {:amount => "100"}
        }.to change(Payment, :count).by(1)
      end

      it "assigns a newly created payment as @payment" do
        post :create, {:amount => "100"}
        assigns(:payment).should be_a(Payment)
        assigns(:payment).should be_persisted
      end

      it "redirects to the user" do
        post :create, {:amount => "100"}
        response.should redirect_to(user_path)
      end
    end
  end
  describe "POST create" do
    before(:each) do
    end
    describe "with invalid amount" do
      it "doesn't create a new Payment" do
        expect {
          post :create, {:amount => "-50"}
        }.to change(Payment, :count).by(0)
      end

      it "does not assign a newly created payment as @payment" do
        post :create, {:amount => "-50"}
        assigns(:payment).should be(nil)
      end

      it "redirects to the user" do
        post :create, {:amount => "-50"}
        response.should redirect_to(payment_path)
      end
    end
  end
  describe "POST create" do
    before(:each) do
    end
    describe "with invalid token" do
      it "doesn't create a new Payment" do
        expect {
          post :create, {:stripe_card_token => "tok_4XQkVhd7Xc2VlK", :amount => "100"}
        }.to change(Payment, :count).by(0)
      end

      it "does not assign a newly created payment as @payment" do
        post :create, {:stripe_card_token => "tok_4XQkVhd7Xc2VlK", :amount => "100"}
        assigns(:payment).should be(nil)
      end

      it "redirects to the user" do
        post :create, {:stripe_card_token => "tok_4XQkVhd7Xc2VlK", :amount => "100"}
        response.should redirect_to(payment_path)
      end
    end
  end


end
