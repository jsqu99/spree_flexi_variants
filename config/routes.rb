Rails.application.routes.draw do
  namespace :admin do
    resources :products do
      resources :option_values
    end
  end
end
