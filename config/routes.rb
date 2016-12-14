Rails.application.routes.draw do
  get 'dashboard/home'

  root 'home#home'

  get 'home/home' => 'pages#show'

  get 'survey_templates' => 'survey_templates#index'

  get 'results_index' => 'survey_templates#results_index'

  resources :data_questions, only: [:update]

  resources :analyses, only: [:update]

  get 'performance_indicators/dashboard' => "performance_indicators#dashboard"

  resources :survey_templates, only: [:index, :edit, :update] do
    resources :data_combinations
    resources :surveys, only: [:new, :create, :show, :edit, :update]
    get 'results', on: :member
  end

  resources :frameworks do
    resources :survey_templates, only: [:new, :create, :show]
    resources :evaluative_questions, only: [:index, :new, :create, :update]
    get 'dashboard', on: :member
  end

  resources :organizations, only: [:new, :create, :edit, :update, :show] do
    resources :programs, only: [:new]
  end


  resources :programs, only: [:create] do
    resources :logic_models, only: [:new, :create]
  end

  resources :logic_models, only: [:show, :edit, :update]

  resources :evaluative_questions, except: [:index, :new, :create] do
    member do
      get 'edit_performance_indicators'
      put 'update_performance_indicators'
    end
  end
  resources :performance_indicators, only: [:index, :edit, :update]
end
