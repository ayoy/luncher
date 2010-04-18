class Lunch < ActiveRecord::Base
  belongs_to :vendor
  has_many :orders
  has_many :users, :through => :orders

  validates_presence_of :vendor_id
  validates_presence_of :name
  validates_presence_of :description
  validates_uniqueness_of :name, :scope => :date

  named_scope :all_for_today, :conditions => {:date => Date.current}
  named_scope :by_date, lambda { |date| {:conditions => {:date => date}} }
  named_scope :ordered_by_date, :order => "date ASC"
  named_scope :ordered_by_name, :order => "name ASC"

  def self.first_available_name_for_date(date)
    lunches = Lunch.by_date(date).ordered_by_name
    names = lunches.map { |lunch| lunch.name[0].chr }.join('')
    ('A'[0]..'Z'[0]).each do |x|
      return x.chr unless names.include? x.chr
    end
  end

  def price_for_user(user)
    return refunded_price if refundable &&
                             Setting.instance.lunch_refunding &&
                             user.refunded_lunches_for_date(date).size < Setting.instance.refunded_lunches_per_day
    price
  end

  def refunded_price
    return price - Setting.instance.money_refunded_per_lunch if refundable
    price
  end

end
