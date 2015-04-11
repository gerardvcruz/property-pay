Rails.application.routes.draw do
  devise_for :users
  resources :properties

  root 'application#home'

  get 'renter' => 'application#renter'

  get 'renter/dashboard' => 'renters#dashboard'

  get 'renter/monthly_rent/' => 'renters#monthly_rent'

  # Owner Routes
  get 'owner' => 'application#owner'

  get 'owner/dashboard' => 'owners#dashboard'

  get 'owner/properties' => 'properties#index'

  get 'owner/renters' => 'owners#renters'



end
