class PayFromBalance
  attr_reader :order, :user

  def initialize(order, user)
    @order = order
    @user = user
  end

  def self.call(order, user)
    new(order, user).call
  end

  def call
    return false unless user.can_pay_for?(order)

    ActiveRecord::Base.transaction do
      order.pay!
      user.decrement! :balance, Order::PRICE
      track_activity
    end

    true
  end

  private

  def track_activity
    Activity.create user: user,
                    subject: order,
                    action: 'payment',
                    data: Order::PRICE
  end
end