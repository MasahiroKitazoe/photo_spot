Rails.application.routes.draw do
  devise_for :users
  root  'static_pages#home'


  resources :prefectures, only: [:index, :show]
  resources :spots, except: [:destroy]
  resources :reviews
end
