Rails.application.routes.draw do
  
  # Carts resources
  resources :carts do
    get '/review_cart',      to: 'carts#show',  as: :edit_cart, on: :collection
  end


  # Products resources
  resources :products, only: [:index, :show]

  # Orders resources
  resources :orders, only: [:create, :update] do
    get    '/confirmation',    to: 'orders#show',            as: :confirmation, on: :collection
    # get    '/edit_order',      to: 'orders#edit',            as: :edit_order, on: :collection
    get    '/check_out',       to: 'orders#new',       as: :check_out, on: :collection
    post   '/process_order',   to: 'orders#process_order',   as: :process_order, on: :collection
    post   '/order_shipped',   to: 'orders#order_shipped',   as: :order_shipped, on: :collection
    post   '/cancel',          to: 'orders#cancel',          as: :cancel, on: :collection
  end

  resources :ordered_items, only: [:create, :update, :destroy]

  # Admin namespace
  namespace :admin do
    # Admin Resources
    resources :products do 
      post '/feature', to: 'products#feature', as: :feature, on: :collection
    end

    resources :images
    resources :featured_products
    
    resources :categories do 
      collection { post :sort }
    end
    
    resources :ordered_items
    resources :orders

    resources :faqs

    # Admin Signin/Signout
    get   'signin',   to: 'sessions#new'
    post  'signin',   to: 'sessions#create'
    get   'signout',  to: 'sessions#destroy', via: 'delete'

    # Admin Root
    root  'dashboard#index'
  end

  # Static Pages
  get 'about',   to: 'public#about',   as: :about
  get 'tos',     to: 'public#tos',     as: :tos
  get 'faq',     to: 'faqs#index',      as: :faq
  get 'contact', to: 'public#contact', as: :contact
  get 'privacy', to: 'public#privacy', as: :privacy

  # Root URL
  root 'public#index'
end
