Rails.application.routes.draw do
  resources :members
  resources :groups do
    patch 'set_organizer', on: :member
  end
  resources :join_groups, only: [:create, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
