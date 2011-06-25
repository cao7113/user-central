OauthProviderDemo::Application.routes.draw do
  devise_for :users, :controllers => { :registrations => 'registrations',
                                       :sessions => 'sessions'}
  #alais some devise-generated routes for convenience
  devise_scope :user do 
    match '/sign_up'=>'registrations#new', :as=>:sign_up 
    match '/sign_in'=>'sessions#new', :as=>:sign_in
    match '/sign_out'=>'sessions#destroy', :as=>:sign_out
    match '/profile/edit'=>"registrations#edit", :as=>:edit_profile
  end
  
                                       
  # omniauth client stuff
  match '/auth/:provider/callback', :to => 'authentications#create'
  match '/auth/failure', :to => 'authentications#failure'

  # Provider stuff
  match '/auth/josh_id/authorize' => 'auth#authorize'
  match '/auth/josh_id/access_token' => 'auth#access_token'
  match '/auth/josh_id/user' => 'auth#user'

  # Account linking
  match 'authentications/:user_id/link' => 'authentications#link', :as => :link_accounts
  match 'authentications/:user_id/add' => 'authentications#add', :as => :add_account

  root :to => 'auth#welcome'
end
