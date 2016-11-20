Rails.application.routes.draw do
  get 'dashboard/home'

  root 'home#home'

  get 'home/home' => 'pages#show'

  get 'survey_templates' => 'survey_templates#index'

  get 'results_index' => 'survey_templates#results_index'

  get 'performance_indicators/dashboard' => "performance_indicators#dashboard"

  resources :survey_templates, only: [:index] do
    resources :surveys, only: [:new, :create, :show, :edit, :update]
    get 'results', on: :member
  end

  resources :frameworks do
    resources :survey_templates, only: [:new, :create, :edit, :update, :show]
    get 'dashboard', on: :member
  end

  resources :organizations, only: [:new, :create, :edit, :update, :show]

  resources :evaluative_questions do
    member do
      get 'edit_performance_indicators'
      put 'update_performance_indicators'
    end
  end
  resources :performance_indicators, only: [:index, :edit, :update]
end
