Rails.application.routes.draw do
  get '/chair', to: 'chairs_dashboard#index', as: 'chairs_dashboard'
end
