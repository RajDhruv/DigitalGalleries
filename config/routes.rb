Rails.application.routes.draw do
  root 'home#index'
  get 'home/index2'
  resources :user, except: [:new, :edit, :update, :destroy, :index] do
  	member do
  		get 'painting/:painting_id',to:'user#show_painting', as:"show_painting"
  		post 'painting',to:'user#create_painting'
  		get 'painting',to:'user#new_painting'
  	end
  end
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
