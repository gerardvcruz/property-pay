class OwnersController < ApplicationController
  before_action :owner?

  def dashboard
    @user_first = User.first # => User.find(1)
  end


  def renters

  end

  def property_renters
    p "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    p property_id = params[:id]
    @property = Property.find(params[:id])
    @users = []
    @user_property = UserProperty.where("property_id = ? AND property_type = ?", params[:id],"renter")
    @user_property.each do |up|
      @users << User.find(up.user_id)
    end
  end

  def renter
    
  end

  private
    def owner?
      unless (user_signed_in? && current_user.user_type == "owner")
        redirect_to root_path
      end
    end
end
