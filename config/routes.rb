Rails.application.routes.draw do

  match 'product_customizations/price', :to => 'product_customizations#price'

  namespace :admin do

    # resources :configuration_exclusions
    resources :product_customization_types do
      resources :customizable_product_options do
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

    resources :ad_hoc_variant_option_types
    resources :product_customization_types

    resources :products do
      resources :ad_hoc_variant_option_types do
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
      resources :product_customization_types do
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
    end #products

  end # namespace :admin
end #draw
