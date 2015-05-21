class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :omniauthable, :omniauth_providers => [:google_oauth2]

  has_many :submitted_texts, class_name: "Text", foreign_key: :submitted_by_id
  has_many :watched_texts
  has_many :texts, through: :watched_texts

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
      user = User.create(name: data["name"],
                         email: data["email"],
                         password: Devise.friendly_token[0,20]
                        )
    end
    user
  end

  def followed_texts
    texts
  end

  def follows_text?(text_id)
    watched_texts.where(text_id: text_id).length > 0
  end

  def texts_tracked

  end

  def sites_tracked

  end

  def authors_tracked

  end

end
