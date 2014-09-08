class Episode < ActiveRecord::Base
  # I guess you can only set default values for the second argument...
  scope :by_number, -> (cool, way = :asc) { order(number: way) }
  scope :by_topic, -> (topic) { tagged_with(topic) }
  
  # Search stuffs
  include PgSearch
  pg_search_scope :search, :associated_against => {
    episode_timestamps: :description
  }

  ##
  # Associations
  has_many :episode_timestamps
  acts_as_taggable_on :topics
  accepts_nested_attributes_for :episode_timestamps
  extend FriendlyId
  friendly_id :title, use: :slugged

  def wecks_date_format
    published_at.strftime('%m.%d.%y')
  end
end
