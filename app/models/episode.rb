# coding: utf-8
class Episode < ActiveRecord::Base
  # I guess you can only set default values for the second argument...
  scope :by_direction, ->(direction = :asc) { order(number: direction.to_sym).order(slug: direction.to_sym)}
  scope :by_topic, ->(topic) { tagged_with(topic) }

  has_attached_file :audio_track
  validates_attachment_content_type :audio_track, content_type: /^audio/
  has_attached_file :video
  validates_attachment_content_type :video, content_type: /^video/
  
  
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
  acts_as_punchable
  
  extend FriendlyId
  friendly_id :title, use: :slugged

  paginates_per 100
  
  def wecks_date_format
    published_at.strftime('%m.%d.%y')
  end

  def media_type_enum
    %w(audio video)
  end
  
  def prev
    Episode.where(Episode.arel_table[:number].lt(self.number))
      .order(number: :desc)
      .order(slug: :desc).first
  end

  def next
    Episode.where(Episode.arel_table[:number].gt(self.number))
      .order(number: :asc)
      .order(slug: :asc).first
  end

  def download_episode
    if media_type.eql? 'audio'
      download_file 'audio_track'
    elsif media_type.eql? 'video'
      download_file 'video'
    end
  end

  # Downloads the file as a temp file
  # saves it to the model file_type passed in
  # => file_type - can be :audio_track or :video
  def download_file(file_type)
    temp_file = File.new(public_url.split('/').last, "wb")
    remote_data = open(URI.parse(public_url))
    temp_file.write(remote_data.read)
    update_attributes(file_type => temp_file)
    File.delete temp_file
  end

  def audio_url
    if audio_track_file_name
      audio_track.url
    else
      public_url
    end
  end

  def audio_download_url
    if audio_track_file_name
      audio_track.url(:original, false)
    else
      public_url
    end
  end
  
  def parse_timestamps
    unparsed = 0
    nodescription = 0
    full_timestamp = 0
    doc = Nokogiri::HTML(wecks_entry)
    topic_name = "NOTTATOPIC"
    doc.css("p").each do |p|
      # Next if this is just the category episode thing
      next if p.text.eql? "Category:Episodes"
      # Next if this is italics (usually air date)
      next if p.children.first.name.eql?  "i"
      # set the topic name of the bold element
      topic_name = p.children.first.text if p.children.first.name.eql? "b"
      # Next if there is no topic set
      next if topic_name.eql? "NOTTATOPIC"
      timestamp = ""
      if p.text[/^((\d+):)?(\d+):?(\d{2})\s*–*-* (.+)$/]
        hour = $2.to_i
        minute = $3.to_i
        second = $4.to_i
        total_seconds = (hour * 3600) + (minute * 60) + second
        description = $5
        timestamp = "hour: #{hour} minute: #{minute} second: #{second} #{description}"
        episode_timestamp = EpisodeTimestamp.find_or_create_by(timestamp: total_seconds,
                                                               description: description,
                                                               episode: self
                                                              )
        topic_list.add(topic_name)
        save
        episode_timestamp.topic_list.add(topic_name)
        episode_timestamp.save
        full_timestamp += 1
      elsif p.text[/^(\d{2})*:*(\d{2}):(\d{2})/]
        hour = $1
        minute = $2
        second = $3
        timestamp = "hour: #{hour} minute: #{minute} second: #{second}"
        nodescription += 1
      else
        next if topic_name.eql? "Seatbelts"
        next if topic_name.eql? p.text
        unparsed += 1
      end
    end
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
