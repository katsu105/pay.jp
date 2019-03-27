class ProductsController < ApplicationController
  def index
  end
  
  def pay
      Payjp.api_key = '
      sk_test_d3a3938ea3c4878fa9363cde'
      charge = Payjp::Charge.create(
      :amount => 3500,
      :card => params['payjp-token'],
      :currency => 'jpy',
  )
  end
end
