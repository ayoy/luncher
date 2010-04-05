class Lunch < ActiveRecord::Base
  has_many :orders
  has_many :users, :through => :orders

  validates_presence_of :date
  validates_presence_of :vendor
  validates_presence_of :name
  validates_presence_of :description
  validates_uniqueness_of :name, :scope => :date
  validates_format_of :name, :with => /[A-Z]/,
                      :message => "The name should be a single uppercase letter (A-Z)"

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
    return refunded_price if refundable && !user.ordered_refunded_lunch_for_date?(date)
    price
  end

  def refunded_price
    return price - 5 if refundable
    price
  end
end
