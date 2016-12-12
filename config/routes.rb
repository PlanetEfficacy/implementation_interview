Rails.application.routes.draw do
  root               to: 'home#index'
  get '/export',     to: 'home#export',                as: 'export'
  get '/chairs',     to: 'chairs_dashboard#index',     as: 'chairs_dashboard'
  get '/categories', to: 'categories_dashboard#index', as: 'categories_dashboard'
end
