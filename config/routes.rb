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

  get 'owner/properties' => 'properties#list'

  get 'owner/renters' => 'owners#renters'

  get 'new_paypal/:ref_id' => 'paypal#new', as: :new_paypal

  get 'paypal_success' => 'paypal#success'

  get 'owner/properties/new' => 'properties#new'

  get 'owner/properties/:id' => 'properties#show'

  get 'owner/properties/:id/edit' => 'properties#edit'

  get 'owner/properties/:id/renters' => 'owners#property_renters'

  get 'owner/properties/:id/renters/:renter_id' => 'owners#renter'

end
