Rails.application.routes.draw do
  devise_for :users
  # get 'dashboard/home'

  root 'home#home'

  # get 'home/home' => 'pages#show'

  get 'survey_templates' => 'survey_templates#index'

  # get 'results_index' => 'survey_templates#results_index'

  resources :organizations, only: [:new, :create, :show] do
    resources :programs, only: [:new, :create]
  end

  resources :analyses, only: [:update]

  get 'performance_indicators/dashboard' => "performance_indicators#dashboard"

  resources :survey_templates, only: [:edit, :update, :show] do
    resources :data_questions, only: [:new, :create]
    resources :data_combinations
    resources :surveys, only: [:new, :create, :show, :edit, :update]
    get 'results', on: :member
  end

  resources :data_questions, only: [:show, :edit, :update] do
    post 'sort', on: :collection
  end

  resources :frameworks, only: [:show] do
    resources :survey_templates, only: [:index, :new, :create]
    resources :evaluative_questions, only: [:index, :new, :create, :update]
    get 'dashboard', on: :member
  end

  resources :programs, only: [:show, :edit, :update] do
    resources :logic_models, only: [:new, :create]
    get 'overview', on: :member
  end

  resources :logic_models, only: [:show, :edit, :update] do
    resources :activities, only: [:new, :create]
    member do
      get 'new_inputs'
      get 'edit_inputs'
      patch 'create_inputs'
      patch 'update_inputs'
      get 'new_outputs'
      get 'edit_outputs'
      patch 'create_outputs'
      patch 'update_outputs'
      get 'new_outcomes'
      get 'edit_outcomes'
      patch 'create_outcomes'
      patch 'update_outcomes'
      get 'new_impacts'
      get 'edit_impacts'
      patch 'create_impacts'
      patch 'update_impacts'
    end
  end

  resources :activities, only: [:show, :edit, :update]

  resources :evaluative_questions, except: [:index] do
    member do
      get 'edit_performance_indicators'
      put 'update_performance_indicators'
    end
  end
  resources :performance_indicators, only: [:index, :edit, :update]
end
