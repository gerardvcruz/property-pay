Rails.application.routes.draw do
  devise_for :users
  resources :properties

  root 'application#renter'

  get 'renter' => 'application#renter'

  get 'renter/dashboard' => 'renters#dashboard'

  get 'renter/monthly_rent/' => 'renters#monthly_rent'

  # Owner Routes
  get 'owner' => 'application#owner'

  get 'owner/dashboard' => 'owners#dashboard'

  get 'owner/properties' => 'properties#index'

  get 'owner/renters' => 'owners#renters'

  get 'new_paypal/:ref_id' => 'paypal#new', as: :new_paypal

  get 'paypal_success' => 'paypal#success'

end
