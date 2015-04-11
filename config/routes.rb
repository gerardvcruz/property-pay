Rails.application.routes.draw do
  devise_for :users
  resources :properties

  root 'application#home'

  get 'renter' => 'application#renter'

  get 'renter/dashboard' => 'renters#dashboard'

  get 'renter/monthly_rent/' => 'renters#monthly_rent'

  # Owner Routes
  get 'owner' => 'application#owner'

  get 'owner/dashboard' => 'application#owner_main'

  get 'owner/properties' => 'application#owner_properties'

  get 'owner/renters' => 'application#owner_renters'

end
