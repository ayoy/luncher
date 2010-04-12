class Vendor < ActiveRecord::Base
  has_many :lunches
  has_many :orders, :through => :lunches
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  def to_s
    name
  end

  def orders_count_for_date(date)
    orders.by_date(date).size
  end

  def users_for_date(date)
    orders.by_date(date).map(&:user).uniq
  end

  def notification_sent_today?
    notification_sent_on == Date.current
  end
end
