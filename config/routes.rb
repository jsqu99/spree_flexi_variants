Spree::Core::Engine.routes.prepend do
  match 'product_customizations/price', :to => 'product_customizations#price', :via => [:get, :post]

  match 'customize/:product_id', :to => 'products#customize', :as => 'customize', :via => [:get, :post]

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

    resources :product_customization_types

    resources :ad_hoc_option_types do
      resources :ad_hoc_option_values do
        collection do
          post :update_positions
        end
      end
      member do
        get :remove
      end
    end

    delete '/ad_hoc_option_values/:id', :to => "ad_hoc_option_values#destroy", :as => :ad_hoc_option_value

    resources :ad_hoc_variant_exclusions

    resources :products do
      resources :option_types do
        member do
          get :select
          get :remove
          get :select_ad_hoc
          post :select_ad_hoc
        end
        collection do
          get :available
          get :selected
          get :available_ad_hoc
        end
      end
      resources :ad_hoc_option_types do
        collection do
          get :selected
        end
        member do
          get :add_option_value
        end
      end

      resources :ad_hoc_variant_exclusions

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

  match 'admin/variant_configurations/:variant_id', :to => 'admin/variant_configurations#configure', :via => [:get, :post]
end
