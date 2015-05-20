class WatchedText < ActiveRecord::Base
  belongs_to :user
  belongs_to :text

  default_scope { order 'version_added_at DESC' }

  def version_added_at
    text.version_added_at
  end
end
