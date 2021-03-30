Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  root 'static_pages#home'
  get '/signup', to: 'users#new'
  resources :users do
    member do
      get :posts, :liked
    end

    resource :relationships, only: [:create, :destroy]
    get 'follows' => 'relationships#follower'
    get 'followers' => 'relationships#followed'
  end
  resources :microposts do
    resource :likes, only: [:create, :destroy]
    resources :comments, only:[:create, :destroy]
  end

end
