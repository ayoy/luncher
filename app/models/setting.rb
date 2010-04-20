class Setting < ActiveRecord::Base
  acts_as_singleton

  def self.toggle_system_locked(value)
    Setting.instance.update_attribute(:system_locked, value)
  end
end
