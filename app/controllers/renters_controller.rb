class RentersController < ApplicationController
  before_action :renter?

  def dashboard
    @user_first = User.first # => User.find(1)
  end

  def rent
  end

  def dues
  end

  private
    def renter?
      unless (user_signed_in? && current_user.user_type == "renter")
        redirect_to root_path
      end
    end
end
