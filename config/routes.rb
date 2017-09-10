Rails.application.routes.draw do

  post 'journeys/:id/end', to: 'journeys#end_journey'
  resources :journeys, only: [:index, :create, :destroy]
  resources :locations, only: [:index, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
