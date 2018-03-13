Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "index#index"

  namespace :api do
    get 'plan' => 'plan#index'
  end
end
