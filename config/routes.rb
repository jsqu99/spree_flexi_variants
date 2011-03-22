Rails.application.routes.draw do
  namespace :admin do

    resources :configuration_exclusions

    resources :customization_types do
      resources :customization_value_types do
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

    resources :products do
      resources :customization_types do
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
      end # option_types
    end #products

    resources :product_option_types do
      resources :product_option_values do
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


  end # namespace :admin
end #draw
