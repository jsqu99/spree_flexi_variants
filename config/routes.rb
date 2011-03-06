Rails.application.routes.draw do
  namespace :admin do
    resources :product_option_types do
      resources :option_values do
        member do
          post :select
          get :remove
        end
        collection do
          get :available
          get :selected
        end
      end
    end
  end
end
