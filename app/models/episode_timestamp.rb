class EpisodeTimestamp < ActiveRecord::Base
  belongs_to :episode
  default_scope { order(timestamp: :asc) }
  acts_as_taggable_on :topics
  before_validation :parse_timestamp


  def display_timestamp
    ChronicDuration.output(timestamp, format: :chrono)
  end
  
  def topic_list_enum
    ActsAsTaggableOn::Tag.all.pluck(:name)
  end


  protected

    def parse_timestamp
      self.timestamp = ChronicDuration.parse(timestamp_before_type_cast) if timestamp_before_type_cast.is_a? String
    end

    rails_admin do
      object_label_method do
        :display_timestamp
      end

      edit do
        field :timestamp, :string
        field :description
        field :topic_list, :enum
      end
    end
end
