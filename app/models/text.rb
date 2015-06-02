require 'notifier'

class Text < ActiveRecord::Base
  include HTTParty
  TXT_FETCH_API = "https://text-fetch.herokuapp.com"

  has_many :versions, dependent: :destroy
  belongs_to :author
  belongs_to :site
  belongs_to :submitted_by, class_name: 'User',
    foreign_key: :submitted_by_id
  has_many :watched_texts, dependent: :destroy
  has_many :watching_users, through: :watched_texts, class_name: 'User',
    source: :user

  validate :unique_selection

  default_scope { order 'version_added_at DESC' }

  ### CLASS METHODS
  def self.find_or_create options
    # TODO Remove below when user auth better set up
    user = options[:user] || User.first
    url = options[:url]
    selector = options[:selector]

    text = Text.find_or_initialize_by(url: url, selector: selector)
    if text.new_record?
      text.check_at = Time.now
      text.submitted_by = user
      Text.fetch_new_version text
      text.watching_users << user
      text.save
    else
      unless user.follows_text? text
        text.watching_users << user
      end
    end
    text
  end

  def self.version_check(text_id)
    text = find text_id
    fetch_new_version text
  end


  def self.fetch_new_version(text)
    content = text.fetch
    text.last_check = Time.now
    if text.md5 == content["md5"]
      text.set_next_check
    else
      version = Version.new(
        text: content["text"],
        title: content["title"],
        md5: content["md5"]
      )

      text.versions << version
      text.update_attributes(
        md5: content['md5'],
        version_added_at: Time.now
      )
      if text.author.nil?
        text.add_author(content["author"])
      end
      if text.site.nil?
        text.add_site(text.url, content["site"])
      end
      text.set_next_check(1.minute)
      if text.version_count > 1
        Notifier.slack(text)
      end
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

  def add_author(options)
    this_author = Author.find_or_create_best(options)
    update_attributes(author_id: this_author.id) unless this_author.nil?
  end

  def add_site(url, options)
    this_site = Site.find_or_create_best(url, options)
    update_attributes(site_id: this_site.id) unless this_site.nil?
  end

  def version_already_exists?
    if versions.count == 0
      false
    else
      versions.where(md5: md5).count > 0
    end
  end

  def set_next_check(addl_time=0)
    new_check = Time.now + (Time.now - latest_version.created_at)*2 + addl_time
    new_check = [new_check, Time.now + 2.days].min
    update_attribute('check_at', new_check)
    Text.delay_until(new_check).version_check(id)
  end

  def latest_version
    versions.last
  end

  def version_count
    versions.count
  end

  def title
    latest_version.title
  end

  def text
    latest_version.text
  end

  # def site
  #   site = url.match(/(http|ftp)s?:\/\/((\w+\.)?(\w+\.)(\w+))\//)
  #   site = site[2] unless site[2].nil?
  #   site.sub!(/^www\./, '')
  #   site.capitalize
  # end

  protected
  def unique_selection
    self.class.exists?(
        :url => url,
        :selector => selector
     )
  end

end
