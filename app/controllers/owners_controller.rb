class OwnersController < ApplicationController
  before_action :owner?

  def dashboard
    @user_first = User.first # => User.find(1)
  end


  def renters
    
  end

  private
    def owner?
      unless (user_signed_in? && current_user.user_type == "owner")
        redirect_to root_path
      end
    end
end
