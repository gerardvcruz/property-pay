Rails.application.routes.draw do
  devise_for :users

  root 'application#home'

  get 'renter' => 'application#renter'

  get 'owner' => 'application#owner'

end
