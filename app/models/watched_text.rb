class WatchedText < ActiveRecord::Base
  belongs_to :user
  belongs_to :text
  validate :unique_pair

  protected
  def unique_pair
    !self.class.exists?(
        :user_id => user_id,
        :text_id => text_id
     )
  end
end
