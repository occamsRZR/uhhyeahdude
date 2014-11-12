class Episode < ActiveRecord::Base
  # I guess you can only set default values for the second argument...
  scope :by_number, ->(cool, way = :asc) { order(number: way).order(slug: way) }
  scope :by_topic, ->(topic) { tagged_with(topic) }
  
  # Search stuffs
  include PgSearch
  pg_search_scope :search, :associated_against => {
    episode_timestamps: :description
  }
  multisearchable against: :description

  ##
  # Associations
  has_many :episode_timestamps, inverse_of: :episode
  accepts_nested_attributes_for :episode_timestamps

  acts_as_votable
  acts_as_taggable_on :topics

  extend FriendlyId
  friendly_id :title, use: :slugged

  paginates_per 100
  
  def wecks_date_format
    published_at.strftime('%m.%d.%y')
  end

  def media_type_enum
    %w(audio video)
  end
  
  protected 

    rails_admin do
      configure :episode_timestamps do
        inverse_of :episode
      end
      list do
        sort_by :number
        field :title
        field :number do
          sort_reverse true
        end
        field :published_at
        field :description
      end
      edit do
        field :title
        field :description, :wysihtml5
        field :media_type
        field :public_url
        field :published_at
        field :number
        field :wecks_entry
        field :slug
        field :episode_timestamps
      end
    end
end
