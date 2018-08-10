Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root to: "books#index"
    get "/home", to: "books#index"
    get "/help", to: "static_pages#help"
    get "/about", to: "static_pages#about"
    get "/contact", to: "static_pages#contact"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "/search", to: "search#search"
    get "/forgot" , to: "password_resets#new"
    get "/password_reset_path" , to: "password_resets#edit"
    get "/addemployee", to: "users#add_employee"
    post "/addemployee", to: "users#create"
    get "/books", to: "books#index"
    get "/show", to: "static_pages#show"
    post "/cart_items", to: "cart_items#create"
    delete "/cart", to: "carts#destroy"
    get "/cart", to: "carts#index"
    resources :orders
    resources :books, only: [:create]
  end

  post "/cart_items/add_quantity", to: "cart_items#update"
  post "/cart_items/reduce", to: "cart_items#update"
  delete "/cart_items/delete", to: "cart_items#destroy"
  get "/new_order", to: "orders#new"
  post "/new_order", to: "orders#create"
  resources :books, only: [:index, :new, :show]
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :edit, :update]
  resources :categories, only: [:index] do
    resources :books, only: [:index, :show, :new, :update]
  end

end
