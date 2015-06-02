require 'slack-notifier'

module Notifier
  def self.slack(text)
    text.watched_texts.each do |watched_text|
      user = watched_text.user
      if should_send?(watched_text) and has_slack?(user)
        notifier = Slack::Notifier.new ENV["SLACK_WEBHOOK"],
          channel: "@#{user.slack_username}",
          username: "ToDifferBot"
        notifier.ping "Update! #{text.url}"
      end
    end
  end

  def self.should_send?(watched_text)
    watched_text.notify
  end

  def self.has_slack?(user)
    !user.slack_username.nil?
  end
end
