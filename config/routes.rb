Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :channels, only: %i[index]
    resources :data_points, only: %i[index]
    resources :devices, only: %i[index]
  end

  root to: 'home#show'
end
