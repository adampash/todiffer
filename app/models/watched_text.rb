class WatchedText < ActiveRecord::Base
  belongs_to :user
  belongs_to :text
end
