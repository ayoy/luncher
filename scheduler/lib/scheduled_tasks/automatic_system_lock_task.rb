class AutomaticSystemLockTask < Scheduler::SchedulerTask
  environments :all
  
  cron "#{Setting.instance.automatic_locking_time.strftime('%M %H')} * * *"
  
  def run
    if Setting.instance.automatic_locking
      Setting.toggle_system_locked(true)
      puts "System automatically locked"
    end
  end
end