OauthProviderDemo::Application.routes.draw do

#  get "client_apps/index"
#  get "client_apps", :to=>"client_apps#index"
#  post "client_apps", :to=>"client_apps#create"
#  delete "client_apps/:id", :to=>"client_apps#destroy"
  resources :client_apps

  get "home/index"

  devise_for :users, :controllers => { :registrations => 'registrations',
                                       :sessions => 'sessions'}
  #alais some devise-generated routes for convenience
  devise_scope :user do 
    match '/sign_up'=>'registrations#new', :as=>:sign_up 
    match '/sign_in'=>'sessions#new', :as=>:sign_in
    match '/sign_out'=>'sessions#destroy', :as=>:sign_out
    match '/profile/edit'=>"registrations#edit", :as=>:edit_profile
  end
  
  # Provider stuff 
  match '/auth/:provider/authorize' => 'auth#authorize'
  match '/auth/:provider/access_token' => 'auth#access_token'
  match '/auth/:provider/user' => 'auth#user'
  
  # omniauth client stuff
  match '/auth/:provider/callback', :to => 'authentications#create'
  match '/auth/failure', :to => 'authentications#failure'
  # Account linking
  match 'authentications/:user_id/link' => 'authentications#link', :as => :link_accounts
  match 'authentications/:user_id/add' => 'authentications#add', :as => :add_account

  root :to => 'home#index'
end
