Rails.application.routes.draw do
  devise_for :players
  resources :games do
    member do
      get 'last_update'
    end
    collection do
      post 'setup'
      post 'select_character'
      post 'unselect_character'
      post 'move_character'
      post 'attack_character'
      post 'end_turn_button'
    end
  end

  root to: 'games#index'
end
