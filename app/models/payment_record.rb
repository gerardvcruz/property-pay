class PaymentRecord < ActiveRecord::Base

  def self.accept_payment user_id
    @payment_record = PaymentRecord.where("user_id = ? AND created_at > ?",
                                          user_id,
                                          last_month).last

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
        @payment_record = PaymentRecord.new
        @payment_record.status = "pending"
        @payment_record.amount = @user.property.rent_price
        @payment_record.balance = @user.property.rent_price
        @payment_record.ref_id = generate_ref_id
        @payment_record.user_id = user_id
        @payment_record.property_id = @user.property.id

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
  private
    def generate_ref_id
      Array.new(6){[*"A".."Z", *"0".."9"].sample}.join
    end

    def last_month
      Date.today - Time.new.day
    end
end
