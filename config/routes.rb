Rails.application.routes.draw do

  namespace :admin do
    get 'order_deralis/update'
  end
  namespace :admin do
    get 'orders/show'
  end
  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
  end
  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]

  end

  namespace :admin do
    get 'homes/top'
  end
  namespace :public do
    get 'cart_items/index'
    get 'cart_items/update'
    get 'cart_items/destroy'
    get 'cart_items/destroy_aii'
    get 'cart_items/create'
  end
  namespace :admin do
    get 'order_deralis/update'
  end
  namespace :admin do
    resources :orders, only: [:show]
  end
  namespace :admin do
    get 'customers/index'
    get 'customers/show'
    get 'customers/edit'
    get 'customers/update'
  end

  namespace :admin do
    get "/" =>'homes#top'
  end
  namespace :public do
    get 'cart_items/index'
    get 'cart_items/update'
    get 'cart_items/destroy'
    get 'cart_items/destroy_aii'
    get 'cart_items/create'
  end
  devise_for :users

  devise_for :customers, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  devise_for :admin, controllers: {
  sessions: "admin/sessions"
  }

  scope module: :public do
   root to: "homes#top"
   get "about" => "homes#about", as: 'about'
   get "customers/mypage" => "customers#show"
   get "customers/information/edit" => "customers#edit"
   patch "customers/information" => "customers#update"
  # 退会確認画面
   get "customers/unsubscribe" => "customers#unsubscribe"
  # 論理的削除用のルーティング
   patch "customers/withdraw" => "customers#withdraw"

   resources :items, only: [:index, :show]
   resources :orders, only: [:new, :create, :show, :index]
     post "orders/confirm" => "orders#confirm"
   resources :addresses, only: [:index, :edit, :create, :update, :destroy]
   resources :cart_items, only: [:index, :update, :destroy, :create]
   delete "cart_items/destroy_all" => "cart_items#destroy_all"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
