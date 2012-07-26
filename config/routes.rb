Goodinc::Application.routes.draw do

  resources :organizations, :only=>[:index, :show, :edit, :update] do
    resources :users do
      member do
        get :reset_password
        get :welcome
      end
    end
    resources :posts, :only => [:create, :destroy, :update] do
      member do
        get :delete
      end
    end
  end

  post "contents/search_resources" => "contents#search_resources", :format=>:js

  resources :applications

  get "password_resets/create"
  get "password_resets/edit"
  get "password_resets/update"
  get "my_account" => "users#my_account"
  put "update_account" => "users#update_account"

  resources :password_resets

  get '/activity', :controller => 'nominations', :action => 'activity'

  resources :nominations

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  get "welcome/index"



  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  get "search" => "search#index"
  get "search/donates" => "search#donates"
  get "search/opportunities" => "search#opportunities"

  get "versions/:id/revert" => "versions#revert", as: :version_revert

  resources :users
  resources :sessions

  get "sessions/new"
  get "users/new"


  # Should stay at the bottom so it doesn't clobber any other routes
  match "/page/:slug", :controller=>:pages, :action=>:show, :as=>"page"

  get 'contact_us', :controller => 'contacted_organizations', :action => 'index', :as => :contactus
  post 'contact_us', :controller => 'contacted_organizations', :action => 'save_contact_us', :as => :save_contact_us

  unless Rails.env.production?
    mount UserMailer::Preview => 'email_preview'
  end


  root :to => 'pages#index'

end
