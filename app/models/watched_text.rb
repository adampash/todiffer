class WatchedText < ActiveRecord::Base
  belongs_to :user
  belongs_to :text
  before_save :set_notification
  validate :unique_pair

  protected
  def set_notification
    if user.slack_username
      self.notify = true
    end
  end

  def unique_pair
    !self.class.exists?(
        :user_id => user_id,
        :text_id => text_id
     )
  end
end
