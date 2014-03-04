class Tag < ActiveRecord::Base

  def self.cloud_for(taggable_class, url)
    taggable_class.tag_counts_on(:tags).map do |tag|
      { text: tag.name, weight: tag.count, link: [url, tag.name].join }
    end
  end
end
