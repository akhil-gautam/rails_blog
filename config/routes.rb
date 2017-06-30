Rails.application.routes.draw do

 	devise_for :users, :controllers => { :registrations => "registrations", :omniauth_callbacks => "callbacks" }
	#resources :users
	resources :articles do
  	resources :comments
	end
  
	default_url_options :host => "gmail.com"
	get 'about/index'
	root 'articles#index'
	get	'friendships/index'

	resources :friendships


end