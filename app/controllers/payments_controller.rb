class PaymentsController < ApplicationController
	require 'stripe'
  # GET /payments
  # GET /payments.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @payments }
    end
  end

  def create
    #p "Entered Create"
  	amount = params[:amount].to_i
    if amount <= 50
      flash[:error] = "Please enter a number greater than 50c"
      redirect_to payment_path
    else
      begin
        charge = Stripe::Charge.create(
        	:amount => params[:amount],
        	:currency => "usd",
        	:card => params[:stripe_card_token],
        	:description => "Charge for #{current_user.name} in the amount of #{amount}"
        )
        @payment = Payment.create(:user_id => current_user.id, :amount => amount)
        current_user.update_attributes(:balance => current_user.balance + amount)
        respond_to do |format|
            format.html { redirect_to user_path, notice: 'Card was charged.' }
            format.json { render json: user_path, status: :created, location: user_path }
        end
      rescue
        flash[:error] = "There was an error processing your card"
        redirect_to payment_path
      end
    end
  end



end
