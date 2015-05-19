class Text < ActiveRecord::Base
  include HTTParty
  TXT_FETCH_API = "https://text-fetch.herokuapp.com"

  has_many :versions, dependent: :destroy
  belongs_to :author
  belongs_to :site
  belongs_to :submitting_user, class_name: 'User',
    foreign_key: :submitted_by_id
  has_many :watched_texts
  has_many :watching_users, through: :watched_texts, class_name: 'User',
    source: :user

  validates :url, uniqueness: true

  ### CLASS METHODS
  def self.find_or_create url, user
    # TODO Remove below when user auth better set up
    user = user || User.first
    text = Text.find_or_initialize_by url: url
    if text.new_record?
      text.check_at = DateTime.now
      text.submitting_user = user
      Text.fetch_new_version text
      text.watching_users << user
      text.save
    end
    text
  end

  def self.fetch_new_version(text)
    content = text.fetch
    text.last_check = DateTime.now
    if text.md5 == content["md5"]
      text.set_next_check
    else
      version = Version.new(
        text: content["text"],
        title: content["title"],
        md5: content["md5"]
      )

      text.versions << version
      text.update_attributes(md5: content['md5'])
      text.set_next_check
    end
  end

  def self.needs_refresh
    where('check_at < ?', Time.now)
  end

  ### INSTANCE METHODS
  def fetch
    params = {
      body:
        {
        format: 'markdown',
        url: url,
        }
    }
    params[:body][:md5] = md5 unless md5.nil?
    params[:body][:selector] = selector unless selector.nil?
    self.class.post TXT_FETCH_API, params
  end

  def version_already_exists?
    if versions.count == 0
      false
    else
      versions.where(md5: md5).count > 0
    end
  end


  def set_next_check
    new_check = Time.now + (Time.now - latest_version.created_at)*2
    new_check = [new_check, Time.now + 2.days].min
    update_attribute('check_at', new_check)
  end

  def latest_version
    versions.last
  end

  def title
    latest_version.title
  end

  def text
    latest_version.text
  end

end
