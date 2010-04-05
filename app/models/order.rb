class Order < ActiveRecord::Base
  belongs_to :lunch # foreign key - lunch_id
  belongs_to :user # foreign key - user_id
  
  validates_presence_of :lunch_id
  validates_presence_of :user_id

  named_scope :by_date, lambda { |date| {:conditions => ["lunches.date = ?", date], :include => :lunch} }
  named_scope :by_user, lambda { |user| {:conditions => {:user_id => user.id} } }
  named_scope :ordered_by_lunch_name, :order => "lunches.name ASC", :include => :lunch
  named_scope :refundable_lunches, :conditions => ["lunches.refundable = ?", true], :include => :lunch
  named_scope :refunded_lunches, :conditions => "lunches.price != total", :include => :lunch
  named_scope :not_refunded_lunches, :conditions => "lunches.price == total", :include => :lunch
  
  before_save :charge_user
  before_destroy :return_money
  after_destroy :refund_other

  def refund
    return_money
    update_attribute(:total, total - 5)
  end

  private

  def charge_user
    user.pay_for_order(self) unless user.nil?
  end

  def return_money
    user.return_money_for_order(self) unless user.nil?
  end

  def refund_other
    refundable_lunches = user.orders.by_date(lunch.date).refundable_lunches
    if refundable_lunches.refunded_lunches.empty?
      other_order = refundable_lunches.not_refunded_lunches.find(:first)
      other_order.refund unless other_order.nil?
    end
  end
end
