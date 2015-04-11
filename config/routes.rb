Rails.application.routes.draw do
  devise_for :users

  root 'application#home'

  get 'renter' => 'application#renter'

  get 'renter/dashboard' => 'application#renter_main'


  # Owner Routes
  get 'owner' => 'application#owner'

  get 'owner/dashboard' => 'application#owner_main'

  get 'owner/properties' => 'application#owner_properties'

  get 'owner/renters' => 'application#owner_renters'

end
