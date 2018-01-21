Rails.application.routes.draw do
  devise_for :users
  root  'static_pages#home'

  #Sign up/Sign inを促すページへのルーティング
  get '/static_pages/demand_sign_in' => 'static_pages#demand_sign_in'

  #ransack用ルーティング
  get '/spots/search' => 'spots#search'

  resources :prefectures, only: [:index, :show]
  resources :spots, except: [:destroy]
  resources :reviews
end
