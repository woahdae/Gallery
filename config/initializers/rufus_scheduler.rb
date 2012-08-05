class Gallery::Jobs
  class << self
    def scheduler
      @scheduler ||= Rufus::Scheduler.start_new
    end
  end
end

Gallery::Jobs.scheduler.cron('0 0 * * *') do
  ClearOldDownloads.call
end
