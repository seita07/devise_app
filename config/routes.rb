Rails.application.routes.draw do
  root 'users#top'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    post '/users/guest_sign_in', to: 'users#guest_sign_in'
  end
  resources :users
  get 'users/:id/report', to: 'users#report'
  resources :timeposts do 
    resources :comments,only: [:create,:destroy]
    resources :timelike,only: [:create,:destroy]
  end
  resources :methodposts do
    resources :reviews,only: [:create,:destroy]
    resources :methodlike,only: [:create,:destroy]
  end
  resources :relationships, only: [:create, :destroy]
end
