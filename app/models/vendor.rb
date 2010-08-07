class Vendor < ActiveRecord::Base
  has_many :lunches, :dependent => :destroy
  has_many :orders, :through => :lunches
  
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :available
  
  named_scope :all_available, :conditions => {:available => true}
  
  def to_s
    name
  end

  def orders_count_for_date(date)
    orders.by_date(date).size
  end

  def notifiable_users_for_date(date)
    orders.by_date(date).map(&:user).uniq.select { |user| user.email_notification_enabled? }
  end
  
  def has_incomplete_orders_for_date?(date)
    !orders.by_date(date).incomplete.empty?
  end

  def notification_sent_today?
    notification_sent_on == Date.current
  end

  def removable?
    lunches.find(:first, :select => 'id').nil?
  end
end
