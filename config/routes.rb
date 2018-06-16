Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  namespace :api, defaults: { format: :json }  do
    namespace :v1 do
      resources :pictures, only: [ :show, :create ]
      post 'pictures/convert', to: "pictures#convert"
    end
  end
end
