

Rails.application.routes.draw do

  resources :events
  resources :nutrient_calcs
  resources :nutrients
  resources :appointments, :pages, :species, :categories, :grows, :pics
  devise_for :users

  get 'signup', to: 'users#new'
  resources :users, except: [:new]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  devise_scope :user do
    authenticated :user do
      root :to => 'trays#index', as: :authenticated_root
    end
    unauthenticated :user do
      root :to => 'devise/sessions#create', as: :unauthenticated_root
    end
  end


  resources :plants do
    member do
      post 'transplant'
    end
    resources :plantdats, :plant_cycles, :tasks
  end

  resources :trays do
    resources :datalogs, :tasks, :tray_cycles
  end
end
