class Text < ActiveRecord::Base
  has_many :versions
  belongs_to :author
  belongs_to :site
  has_many :users, through: :watched_texts
end
