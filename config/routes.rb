Rails.application.routes.draw do

	# match "/users/auth/:provider/callback", to: 'callbacks#create', via: [:get, :post]
	# match '/logout', to: 'callbacks#destroy', via: [:get, :post]
   	devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  	resources :users
  	resources :articles do
    	resources :comments
  	end
  	default_url_options :host => "gmail.com"
  	get 'about/index'
 
  	root 'articles#index'
end