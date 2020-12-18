Rails.application.routes.draw do

  get 'users/index'

  resources :posts
  devise_for :users, controllers: { sessions: "sessions", registrations: "registrations" }

  devise_scope :user  do
    get  'users/admin_new' => 'users#admin_new'
    post 'users/admin_create' => 'users#admin_create'
  end

  resources :users
  resources :authors do
    collection do
      get :postsbyauthor
    end
  end
  root :to => 'users#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
