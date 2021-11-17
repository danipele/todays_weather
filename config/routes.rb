Rails.application.routes.draw do
  root to: 'limits#index'

  resources :limits, only: [:index]

  get '/edit', to: 'limits#edit'
  post '/update', to: 'limits#update'
  post '/find_weather', to: 'limits#find_weather'
end
