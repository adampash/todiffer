class TextRefreshWorker
  include Sidekiq::Worker

  def perform
    Text.needs_refresh.each do |text|
      puts "checking for #{text.id}"
      Text.fetch_new_version text
      puts "Check again at #{text.reload.check_at}"
    end
  end
end
