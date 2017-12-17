class Feed < ApplicationRecord
  has_many :entries, dependent: :destroy
  validates_presence_of :name, :url, :description
  after_save :clear_cache

  def clear_cache
    $redis.del "feeds"
  end
end
