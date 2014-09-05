class Episode < ActiveRecord::Base
  # I guess you can only set default values for the second argument...
  scope :by_number, -> (cool, way = :asc) { order(number: way) }
  ##
  # Associations
  has_many :episode_timestamps
  acts_as_taggable_on :topics
  accepts_nested_attributes_for :episode_timestamps
  extend FriendlyId
  friendly_id :title, use: :slugged
end
