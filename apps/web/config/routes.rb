root to: 'home#index'

resources :registrations, only: %i[new create]
resources :sessions, only: %i[new create]
delete 'sessions', to: 'sessions#destroy', as: :session

resources :users
