Rails.application.routes.draw do
  resources :categories, param: :slug

  # replace the name blogs to blog
  resources :blogs, param: :slug, path: :blog do
    resources :comments
  end
  resources :contacts
  resources :products
  # only: /users/sign_in and /users/sign_out
  devise_for :users

  resources :chats, only: [:index] do
    collection do
      post :process_input
    end
  end
  resources :about, only: [:index]
  resources :services, only: [:index]
  resources :faqs, only: [:index]
  resources :contact_informations, only: [:index]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"

  authenticated :user, ->(u) { Rails.env.development? || u.admin? } do
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  end
end