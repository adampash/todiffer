class Site < ActiveRecord::Base
  has_many :texts

  def self.find_or_create_best(options)
    twitter_handle = options["twitter"]
    site_name = options["name"]
    return nil if twitter_handle.nil? and site_name.nil?
    unless twitter_handle.nil?
      site = find_by(twitter: twitter_handle)
    end
    if site.nil?
      site = find_by(name: site_name)
    end
    if site.nil?
      site = create(
        twitter: twitter_handle,
        name: site_name,
      )
    end
    site
  end
end
