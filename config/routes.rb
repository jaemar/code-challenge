Rails.application.routes.draw do
  namespace :api, constraints: { format: :json } do
    namespace :v1 do
      resources :carts, only: [ :create, :show ]
    end
  end
end
