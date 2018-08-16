root to: 'home#index'

resources :sessions, only: %i[new create]
delete 'sessions', to: 'sessions#destroy', as: :session

resources :users
