Rails.application.routes.draw do
  get 'dashboard/home'

  root 'home#home'

  get 'home/home' => 'pages#show'

  get 'survey_templates' => 'survey_templates#index'

  get 'performance_indicators/dashboard' => "performance_indicators#dashboard"

  resources :survey_templates, only: [:index] do
    resources :surveys, only: [:new, :create]
  end

  resources :frameworks do
    resources :survey_templates, only: [:new, :create, :edit, :update, :show]
  end
  resources :evaluative_questions do
    member do
      get 'edit_performance_indicators'
      put 'update_performance_indicators'
    end
  end
  resources :performance_indicators, only: [:index, :edit, :update]
end
