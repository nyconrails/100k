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
  
  #   resources :contents

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  get "welcome/index"



  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  get "search" => "search#index"
  get "search/donates" => "search#donates"
  get "search/opportunities" => "search#opportunities"

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

  #match "*path" => 'pages#not_found'
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
