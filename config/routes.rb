require 'sidekiq/web'
Littlefire::Application.routes.draw do
  devise_for :users, :controllers=>{:registrations => "registrations",:passwords => "passwords"}
  devise_for :admin_users, :controllers=>{:registrations => "registrations",:passwords => "passwords"}
  mount Ckeditor::Engine => '/ckeditor'
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  mount Sidekiq::Web => '/sidekiq'
  resources :categories, only: [:index, :show]
  resources :posts, only: [:index, :new, :create, :show]
  resources :deals do
    member do
      get 'unfold'
    end
    collection do
      get 'search'
    end
  end
  resources :deals, only: [:index, :new, :create, :show]
  get 'user/dashboard' => 'user#dashboard'
  get 'user/profile' => 'user#profile'
  
  namespace :user do
    resources :deals, except: :destroy
    resources :pictures, only: :create
    resources :credit_histories, only: [:index]
    resources :grades, except: :destroy
    resources :deals do
      resources :comments do
        collection do
          get 'show_recent'
        end
      end
      resources :favorites
    end
    resources :comments
    resources :favorites
  end
  
  get "syncs/:type/new" => "syncs#new", :as => :sync_new
  get "syncs/:type/callback" => "syncs#callback", :as => :sync_callback
  
  root 'welcome#index'
  get 'welcome/notify' => 'welcome#notify'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  
  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
  
end
