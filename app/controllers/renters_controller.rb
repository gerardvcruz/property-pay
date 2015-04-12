class RentersController < ApplicationController
  before_action :renter?

  def dashboard
    @payment_record = PaymentRecord.where("user_id = ? AND status != ?",
                                          current_user.id, "paid").last
    if @payment_record.nil?
      @payment_record = PaymentRecord.where("user_id = ?", current_user.id).last
    end
    @user_property = UserProperty.find_by_user_id(current_user.id)
    @property = Property.find(@user_property.property_id)
  end

  def monthly_rent
    @payment_records = PaymentRecord.where(user_id: current_user.id).order('created_at DESC')
    @balance = 0
    @payment_records.each do |pr|
      @balance += pr.balance
    end
  end

  private
    def renter?
      unless (user_signed_in? && current_user.user_type == "renter")
        redirect_to root_path
      end
    end
end
