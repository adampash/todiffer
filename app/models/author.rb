class Author < ActiveRecord::Base

  def self.find_or_create_best(options)
    twitter_handle = options["twitter"]
    author_name = options["name"]
    return nil if twitter_handle.nil? and author_name.nil?
    unless twitter_handle.nil?
      author = find_by(twitter: twitter_handle)
    end
    if author.nil?
      author = find_by(name: author_name)
    end
    if author.nil?
      author = create(
        twitter: twitter_handle,
        name: author_name,
      )
    end
    author
  end
end
