class CardsController < ApplicationController
  protect_from_forgery :except => [:create]
  def new
  end

  def create
    
    binding.pry
    
    @card = Card.new(card_params)
    @card.save
    
  end

  private

  def card_params
    params.permit(:pay_id)
  end
end
