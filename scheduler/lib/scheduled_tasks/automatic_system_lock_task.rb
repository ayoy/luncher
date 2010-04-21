class AutomaticSystemLockTask < Scheduler::SchedulerTask
  environments :all
  
  cron "#{Setting.instance.automatic_locking_time.strftime('%M %H')} * * *"
  
  def run
    Setting.toggle_system_locked(true) if Setting.instance.automatic_locking
    puts "System automatically locked"
  end
end