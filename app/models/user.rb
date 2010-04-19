class User < ActiveRecord::Base
  has_and_belongs_to_many :user_groups
  has_many :orders
  has_many :lunches, :through => :orders
  
  acts_as_authentic

  validates_presence_of :login
  validates_presence_of :email
  validates_presence_of :first_name
  validates_presence_of :last_name
  
  named_scope :ordered_by_login, :order => "login ASC"
  named_scope :ordered_by_last_name,
              :order => "last_name ASC",
              :conditions => "login != 'root'"
  
  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end

  def full_name
    [last_name, first_name].join(' ')
  end
  
  def refunded_lunches_for_date(date)
    orders.by_date(date).refundable_lunches
  end

  def can_order_lunch?(lunch)
    balance >= lunch.price_for_user(self) && lunch.date >= Date.current
  end
  
  def pay_for_order(order)
    update_attribute(:balance, balance - order.total)
  end
  
  def return_money_for_order(order)
    update_attribute(:balance, balance + order.total)
  end

end
