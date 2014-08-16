Rails.application.routes.draw do
  devise_for :players
  resources :games do
    member do
      post 'setup'
    end
  end

  root to: 'games#index'
end
