class PaymentRecord < ActiveRecord::Base

  def self.accept_payment user_id
    @payment_record = PaymentRecord.where("user_id = ? AND created_at > ?",
                                          user_id, Date.today - Time.new.day).last

    if @payment_record.nil?
      @message = {:message => "payment record not found", :success => false}
    else
      @payment_record.status = "paid"
      @payment_record.balance = 0
      if @payment_record.save
        @message = {:message => "payment record payment success", :success => true}
      else
        @message = {:message => "payment record accept payment failed", :success => false}
      end
    end

  end

  def self.bill_renter user_id
    if User.find(user_id).nil?
      @message = {:message => "user not found", :success => false}
    else
      @user = User.find(user_id)
      if PaymentRecord.last.created_at < Date.today - Time.new.day
        @property = Property.find(UserProperty.find_by_user_id(user_id).property_id)
        @payment_record = PaymentRecord.new
        @payment_record.status = "pending"
        @payment_record.amount = @property.rent_price
        @payment_record.balance = @property.rent_price
        @payment_record.ref_id = Array.new(6){[*"A".."Z", *"0".."9"].sample}.join
        @payment_record.user_id = user_id
        @payment_record.property_id = @property.id

        if @payment_record.save!
          @message = {:message => "saved", :success => true}
        else
          @message = {:message => "error saving", :success => false}
        end
      else
        @message = {:message => "already charged for this month", :success => false}
      end
    end
  end
end
