Rails.application.routes.draw do
  devise_for :users
  resources :properties

  root 'application#renter'

  get 'renter' => 'application#renter'

  get 'renter/dashboard' => 'renters#dashboard'

  get 'renter/monthly_rent/' => 'renters#monthly_rent'

  get 'new_paypal' => 'paypal#new'

  # Owner Routes
  get 'owner' => 'application#owner'

  get 'owner/dashboard' => 'owners#dashboard'

  get 'owner/properties' => 'properties#list'

  get 'owner/renters' => 'owners#renters'

  get 'owner/properties/new' => 'properties#new'

  get 'owner/properties/:id' => 'properties#show'

end
