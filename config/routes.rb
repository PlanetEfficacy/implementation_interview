Rails.application.routes.draw do
  get '/chairs',     to: 'chairs_dashboard#index',     as: 'chairs_dashboard'
  get '/categories', to: 'categories_dashboard#index', as: 'categories_dashboard'
end
