Rails.application.routes.draw do
  devise_for :users
  root 'users#index'
  resources :users do
    resources :posts do
      resources :comments
      resources :likes
    end
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [] do
        resources :posts, only: %i[index]
      end

      resources :users, only: [] do
        resources :posts, only: %i[index show new create] do
          resources :comments, only: %i[new create]
          resources :likes, only: %i[new create]
        end
      end

      resources :posts, only: [] do
        resources :comments, only: %i[index create]
      end
    end
  end
end
