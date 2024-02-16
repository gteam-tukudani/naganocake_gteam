Rails.application.routes.draw do

  devise_for :users

  devise_for :customers, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  devise_for :admin, controllers: {
  sessions: "admin/sessions"
}
# 顧客側のルーティング
  scope module: :public do
   root to: "homes#top"
   get "homes/about" => "homes#about", as: 'about'
   get "customers/mypage" => "customers#show"
   get "customers/information/edit" => "customers#edit"
   patch "customers/information" => "customers#update"
  # 退会確認画面
   get "customers/unsubscribe" => "customers#unsubscribe"
  # 論理的削除用のルーティング
   patch "customers/withdraw" => "customers#withdraw"
   get "customers/mypage" => "customers/show"
   get "customers/information/edit" => "customers/edit"
   patch "customers/information" => "customers/update"
   get "customers/unsubscribe" => "customers/unsubscribe"
   patch "customers/withdraw" => "customers/withdraw"
   resources :orders, only: [:new, :create, :show, :index]
   resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
