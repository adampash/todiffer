class Version < ActiveRecord::Base
  belongs_to :base_text, class_name: "Text", foreign_key: :text_id
end
