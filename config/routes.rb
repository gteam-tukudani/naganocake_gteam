Rails.application.routes.draw do

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
   get "homes/about" => "homes#about", as: 'about'
   get "customers/mypage" => "customers/show"
   get "customers/information/edit" => "customers/edit"
   patch "customers/information" => "customers/update"
   get "customers/unsubscribe" => "customers/unsubscribe"
   patch "customers/withdraw" => "customers/withdraw"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
