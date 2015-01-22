Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :users, :only => [:index, :show]
  
  root to: 'high_voltage/pages#show', id: 'home'
  get '/search' => 'search#search', :as => :search
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
  resources :episodes do 
    member do
      post :annotate
      get :dope
      get :nope
    end
  end
end
