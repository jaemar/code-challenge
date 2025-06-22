Rails.application.routes.draw do
  namespace :api, constraints: { format: :json } do
    namespace :v1 do
      resources :carts, only: [ :create, :show, :index ] do
        post :add_to_basket, on: :member
      end

      resources :products, only: [ :index ]
    end
  end
end
