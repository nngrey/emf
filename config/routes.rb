Rails.application.routes.draw do
  get 'dashboard/home'

  root 'home#home'

  get 'home/home' => "pages#show"

  get 'performance_indicators/dashboard' => "performance_indicators#dashboard"

  resources :frameworks
  resources :evaluative_questions
  resources :performance_indicators, only: [:index, :edit, :update]
end
