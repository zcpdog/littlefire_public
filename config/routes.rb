require 'sidekiq/web'
Littlefire::Application.routes.draw do
  devise_for :users, :controllers=>{:registrations => "registrations",:passwords => "passwords"}
  devise_for :admin_users
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  authenticate :admin_user, lambda { |u| u.has_role? "admin" } do
    mount Sidekiq::Web => '/sidekiq'
  end
  
  resources :ueditor_images, only: [:create]
  resources :categories, only: [:index, :show]
  resources :experiences, only: [:index,:show,:new,:create]
  resources :deals do
    member do
      get 'purchase'
    end
    get 'page/:page', :action => :index, :on => :collection
  end
  
  resources :discoveries do
    member do
      get 'purchase'
    end
    get 'page/:page', :action => :index, :on => :collection
  end
  
  resources :deals, only: [:index, :new, :create, :show]
  resources :grades, except: :destroy
  resources :comments
  resources :favorites
  
  namespace :user do
    resources :deals, except: [:destroy, :update]
    resources :discoveries, except: [:destroy, :update]
    resources :pictures, only: :create
    resources :credit_histories, only: [:index]
    resources :grades, except: :destroy
    resources :deals do
      resources :comments 
      resources :favorites
      resources :grades
    end
    resources :discoveries do
      resources :comments 
      resources :favorites
      resources :grades
    end
    resources :experiences do
      resources :comments 
      resources :favorites
      resources :grades
    end
    resources :comments
    resources :favorites
  end
  patch '/user/update_password' => 'user#update_password'
  patch '/user/update_avatar' => 'user#update_avatar'
  get '/user/profile' => 'user#profile'
  resources :user
  
  get 'notify' => 'notify#show'
  get 'search' => 'deals#search'
  root 'deals#index'
end
