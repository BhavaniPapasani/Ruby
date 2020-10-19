Rails.application.routes.draw do
  get 'welcome/index'
  resources :authors do
    collection do
      get :postsbyauthor
    end
  end
  resources :posts
  root to: 'welcome#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
