class EpisodeTimestamp < ActiveRecord::Base
  belongs_to :episode, inverse_of: :episode_timestamps

  acts_as_taggable_on :topics
  before_validation :parse_timestamp

  # Validations
  ##
  validates_presence_of :episode, :description

  # Scopes
  ##
  default_scope { order(timestamp: :asc) }

  def display_timestamp(format = :short)
    ChronicDuration.output(timestamp, format: format)
  end
  
  def topic_list_enum
    ActsAsTaggableOn::Tag.all.pluck(:name)
  end


  protected

    def parse_timestamp
      self.timestamp = ChronicDuration.parse(timestamp_before_type_cast) if timestamp_before_type_cast.is_a? String
    end

    def object_label
      "#{display_timestamp(:chrono)} #{topic_list}"
    end

    rails_admin do
      object_label_method do
        :object_label
      end
      visible false
      edit do
        field :timestamp, :string do
          formatted_value do
            bindings[:object].display_timestamp(:chrono)
          end
        end
        field :description, :wysihtml5
        field :topic_list, :enum
      end
    end
end
