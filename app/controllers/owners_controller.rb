class OwnersController < ApplicationController
  before_action :owner?

  def dashboard
  end

  def property_renters
    @property = Property.find(params[:id])
    @users = []
    @user_property = UserProperty.where("property_id = ? AND property_type = ?", params[:id], "renter")
    @user_property.each do |up|
      @users << User.find(up.user_id)
    end
  end

  def renter
    @user = User.find(params[:renter_id])
    @user_property = UserProperty.where(user_id: @user.id).first
    @property = Property.find(@user_property.property_id)
  end

  def bill_renter
    @message = PaymentRecord.bill_renter params[:user_id]
    if @message[:success]
      redirect_to bill_success_path(@message)
    else
      redirect_to bill_failed_path(@message)
    end
  end

  def bill_success
    @params = params
  end

  def bill_failed
    @params = params
  end

  private
    def owner?
      unless (user_signed_in? && current_user.user_type == "owner")
        redirect_to root_path
      end
    end
end
