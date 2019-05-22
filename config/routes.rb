Rails.application.routes.draw do
  resources :features,  only: [:index, :show] do
    resources :comments, only: [:index, :create]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
