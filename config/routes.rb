Rails.application.routes.draw do
  # Add your extension routes here

  namespace :admin do
    resources :product_option_values do
      member do
        get :remove
      end
    end
    resources :option_types do
      member do
        get :select
        get :configure
        get :edit_configuration
        get :remove
      end
      collection do
        get :available
        get :selected
      end
    end
  end
end
