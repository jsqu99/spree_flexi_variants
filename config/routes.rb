Rails.application.routes.draw do
  namespace :admin do
    resources :products do
      resources :option_types do
        member do
          get :select
          post :select  # as well as 'get'.  see the view file for why i need both
          get :remove
        end
        collection do
          get :available
          get :selected
        end
      end
    end
    resources :product_option_types do
      resources :option_values do
        member do
          get :select
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
