class CardsController < ApplicationController
  protect_from_forgery :except => [:create]
  before_action :set_pay_jp_api_key, only: [:create, :show]
  def new
    
  end

  def create
    # トークンIDと顧客データを生成し、紐つける
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

  def show
    binding.pry
    # 顧客データを取得できるかテスト
    customer_id = current_user.card.customer_id
    customer = Payjp::Customer.retrieve(customer_id)
  end
  private

  def card_params
    params.permit(:pay_id)
  end

  def set_pay_jp_api_key
    Payjp.api_key = 'sk_test_d3a3938ea3c4878fa9363cde'
  end
end
