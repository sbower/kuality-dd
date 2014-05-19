Rails.application.routes.draw do

  resources :features
  resources :scenarios
  resources :tags
  resources :steps
  
  root 'features#index'
  get 'runfeature' => 'features#run'
  post 'search' => 'search#search'
  
  
end
