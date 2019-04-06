Rails.application.routes.draw do
  devise_for :users
  root 'cards#new'
  post 'pay'            => 'cards#create'
  get  'products'       => 'products#index'
  post 'products/pay'   => 'products#pay'
  get  'cards/show'       => 'cards#show'
  resources :payments
end
