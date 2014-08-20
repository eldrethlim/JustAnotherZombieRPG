Rails.application.routes.draw do
  devise_for :players
  resources :games do
    collection do
      post 'setup'
      post 'select_character'
      post 'unselect_character'
      post 'move_character'
      post 'attack_character'
    end
  end

  root to: 'games#index'
end
