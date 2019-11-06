Rails.application.routes.draw do
  # Это правило говорит: если пользователь заходит по адресу /, направь его в
  # контроллер users, действие index. Грубо говоря, на главной странице у нас
  # список юзеров.
  root 'users#index'

  resources :users, except: [:destroy]
  resources :questions

  end
