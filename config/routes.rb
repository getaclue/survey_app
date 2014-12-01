Rails.application.routes.draw do
  #########################################################
  # Note: 
  # To see all routes:
  # bundle exec rake routes
  #########################################################
  
  #########################################################
  # main routes
  #########################################################
  root 'pages#index'
  get   'signin'      => 'sessions#new'
  post  'signin'      => 'sessions#create'
  delete   'signout'  => 'sessions#destroy'
  get   'signup'      => 'users#new'
  
  #########################################################
  # user routes
  #########################################################
  resources :users
  
  #########################################################
  # routing for the survey and questions
  #########################################################
  resources :surveys, only: [:create, :destroy, :show, :update] do
    resources :questions, only: [:create, :update, :destroy]
    resources :survey_items, only: [:show, :create, :update]
  end
  
  #########################################################
  # routing for questions and answers of a survey
  #########################################################
  resources :questions, only: [:show] do
    resources :answers, only: [:new, :create, :destroy, :update]
    resources :vote_items, only: [:create, :destroy, :edit, :update]
  end
  
end
