Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    post 'users_guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  get 'home/index'

  root 'home#index'

  resources :books do
    collection do
      get :search  # GETメソッドでの検索を許可
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
