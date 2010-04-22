class AutomaticSystemLockTask < Scheduler::SchedulerTask
  environments :all
  
  cron Setting.automatic_locking_time_to_cron
  
  def run
    if Setting.instance.automatic_locking
      Setting.toggle_system_locked(true)
      puts "System automatically locked"
    end
  end
end
