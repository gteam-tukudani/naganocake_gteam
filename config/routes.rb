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
   get "custmers/mypage" => "custmers/show"
   get "custmers/information/edit" => "custmers/edit"
   patch "custmers/information" => "custmers/update"
   get "custmers/unsubscribe" => "custmers/unsubscribe"
   patch "custmers/withdraw" => "custmers/withdraw"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
