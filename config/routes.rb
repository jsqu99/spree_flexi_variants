Rails.application.routes.draw do
  # Add your extension routes here

  namespace :admin do
    resources :product_option_values do
      member do
        get :remove
      end
    end
    resources :option_values do
      member do
        get :remove
      end
    end
    resources :option_types do
      member do
        get :select
        get :configure_dynamic_option_values
        get :configure_dynamic_option_values_for_product
        get :edit_dynamic_option_values_for_product
        get :remove
      end
      collection do
        get :available
        get :selected
      end
    end
  end
end
