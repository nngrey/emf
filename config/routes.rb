Rails.application.routes.draw do
  # get 'dashboard/home'

  root 'home#home'

  # get 'home/home' => 'pages#show'

  get 'survey_templates' => 'survey_templates#index'

  get 'results_index' => 'survey_templates#results_index'

  resources :organizations, only: [:new, :create, :edit, :update, :show] do
    resources :programs, only: [:new]
  end

  resources :analyses, only: [:update]

  get 'performance_indicators/dashboard' => "performance_indicators#dashboard"

  resources :survey_templates, only: [:edit, :update, :show] do
    resources :data_questions, except: [:edit]
    resources :data_combinations
    resources :surveys, only: [:new, :create, :show, :edit, :update]
    get 'results', on: :member
  end

  resources :data_questions, only: [:edit, :update] do
    post 'sort', on: :collection
  end

  resources :frameworks do
    resources :survey_templates, only: [:index, :new, :create]
    resources :evaluative_questions, only: [:index, :new, :create, :update]
    get 'dashboard', on: :member
  end



  resources :programs, only: [:create, :show] do
    resources :logic_models, only: [:new, :create]
    get 'overview', on: :member
  end

  resources :logic_models, only: [:show, :edit, :update] do
    resources :activities, only: [:new, :create]
    member do
      get 'new_inputs'
      patch 'create_inputs'
      get 'new_outputs'
      patch 'create_outputs'
      get 'new_outcomes'
      patch 'create_outcomes'
      get 'new_impacts'
      patch 'create_impacts'
    end
  end

  resources :activities, only: [:show]

  resources :evaluative_questions, except: [:index, :new, :create] do
    member do
      get 'edit_performance_indicators'
      put 'update_performance_indicators'
    end
  end
  resources :performance_indicators, only: [:index, :edit, :update]
end
