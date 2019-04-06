class CardsController < ApplicationController
  protect_from_forgery :except => [:create]
  before_action :set_pay_jp_api_key, only: [:create]
  def new
    
  end

  def create
    customer = Payjp::Customer.create(
      description: 'test',
      card: params[:pay_id]
    )
    card = Card.new(
      pay_id: params[:pay_id],
      customer_id: customer.id,
      user_id: current_user.id)
    card.save
  end

  private

  def card_params
    params.permit(:pay_id)
  end

  def set_pay_jp_api_key
    Payjp.api_key = 'sk_test_d3a3938ea3c4878fa9363cde'
  end
end
