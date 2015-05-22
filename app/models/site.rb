class Site < ActiveRecord::Base
  has_many :texts

  def self.find_or_create_best(url, options)
    twitter_handle = options["twitter"]
    domain = get_domain url
    site_name = options["name"] || domain.capitalize
    if twitter_handle.nil?
      site = find_by(name: site_name, domain: domain)
    else
      site = find_by(name: site_name, domain: domain, twitter: twitter_handle)
    end
    require 'pry'; binding.pry
    if site.nil?
      site = create(
        twitter: twitter_handle,
        name: site_name,
        domain: domain,
      )
    end
    site
  end

  def self.get_domain(url)
    domain_regex = /^(http|ftp)s?:\/\/(([\w\d\-_]+\.)?([\w\d\-_]+)\.(\w+))\//
    matches = url.match domain_regex
    domain = matches[2]
    domain.sub(/^www\./, '')
  end
end
