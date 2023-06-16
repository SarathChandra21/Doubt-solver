Rails.application.routes.draw do
  root "pages#home"
  resources :questions
  get 'signup1', to: 'students#new'
  resources :students, except: [:new]
  get 'signup2', to: 'teachers#new'
  resources :teachers, except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'myquestions', to: 'questions#index1'
  get 'unanswered', to: 'questions#unanswered'
  get 'login2', to: 'sessions#new2'
  post 'login2', to: 'sessions#create2'
  delete 'logout2', to: 'sessions#destroy2'
  resources :topics, except: [:destroy]
  get 'dashboard', to: "pages#stats"
  get 'pages/update', to: 'pages#update'
  post 'questions/index2', to: 'questions#index2'

end
