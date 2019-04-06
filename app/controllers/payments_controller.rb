class PaymentsController < ApplicationController
  protect_from_forgery :except => [:create]
  before_action :set_pay_jp_api_key, only: [:create]

  def create
    customer_id = current_user.card.customer_id
    charge = Payjp::Charge.create(
    amount: 3500,
    currency: 'jpy',
    customer: customer_id,
    )
    redirect_to "/products"
  end

  private
  def set_pay_jp_api_key
    Payjp.api_key = 'sk_test_d3a3938ea3c4878fa9363cde'
  end
end
