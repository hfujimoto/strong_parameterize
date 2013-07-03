Rails.application.routes.draw do
  namespace :vote do
    resources :disagrees
  end

  namespace :vote do
    resources :agrees
  end

  resources :diaries
  resources :users
end
