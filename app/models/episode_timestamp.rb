class EpisodeTimestamp < ActiveRecord::Base
  belongs_to :episode
  default_scope { order(timestamp: :asc) }
  acts_as_taggable_on :topics
  before_validation :parse_timestamp


  def display_timestamp
    ChronicDuration.output(timestamp, format: :chrono)
  end

  protected

    def parse_timestamp
      self.timestamp = ChronicDuration.parse(timestamp_before_type_cast) if timestamp_before_type_cast.is_a? String
    end

    rails_admin do
      edit do
        field :timestamp, :string
        field :description
        field :topics
      end
    end
end
