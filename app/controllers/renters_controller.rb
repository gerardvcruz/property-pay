class RentersController < ApplicationController
  before_action :renter?

  def dashboard
    @payment_record = PaymentRecord.where("user_id = ? AND created_at > ?", current_user.id, Date.today - Time.new.day).first
    @user_property = UserProperty.find_by_user_id(current_user.id)
    @property = Property.find(@user_property.property_id)
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
