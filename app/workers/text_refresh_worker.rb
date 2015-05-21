# class TextRefreshWorker
#   include Sidekiq::Worker

  # def perform(text_id)
  #   text = Text.find text_id
  #   Text.fetch_new_version text
  # end

  # def perform
  #   Text.needs_refresh.each do |text|
  #     puts "checking for #{text.id}"
  #     Text.fetch_new_version text
  #     puts "Check again at #{text.reload.check_at}"
  #   end
  # end
# end
