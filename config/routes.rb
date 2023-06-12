Rails.application.routes.draw do
  root "pages#home"
  resources :questions
  get 'signup1', to: 'students#new'
  resources :students, except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'myquestions', to: 'questions#index1'
end
