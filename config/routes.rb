Rails.application.routes.draw do
  devise_for :users
  root  'static_pages#home'
  get '/static_pages/demand_sign_in' => 'static_pages#demand_sign_in'

  resources :prefectures, only: [:index, :show]
  resources :spots, except: [:destroy]
  resources :reviews
end
