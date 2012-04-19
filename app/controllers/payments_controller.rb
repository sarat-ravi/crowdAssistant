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
  	amount = params[:amount].to_i
    @payment = Payment.create(:user_id => current_user.id, :amount => amount)
    Stripe::Charge.create(
    	:amount => params[:amount],
    	:currency => "usd",
    	:card => params[:stripe_card_token],
    	:description => "Charge for #{current_user.name} in the amount of #{amount}"
    )
    current_user.update_attributes(:balance => current_user.balance + amount)
    respond_to do |format|
        format.html { redirect_to user_path, notice: 'Card was successfully charged.' }
        format.json { render json: user_path, status: :created, location: user_path }
    end
  end



end
