class Vendor < ActiveRecord::Base
  has_many :lunches
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  def to_s
    name
  end
end
