




  task admin_roundup_daily:  :environment do
    AdminRoundupJob.perform("daily")
    puts " finished daily admin roundup"
  end

  task :admin_roundup_weekly => :environment do
    AdminRoundupJob.perform("weekly")
    puts " finished weekly admin roundup"
  end

  task :admin_roundup_monthly => :environment do
    AdminRoundupJob.perform("monthly")
    puts " finished weekly admin roundup"
  end



