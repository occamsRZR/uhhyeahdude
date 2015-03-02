class RSSFeedUpdaterWorker
  include Sidekiq::Worker
  sidekiq_options queue: :rss, retry: false
  
  def perform
    feed = Feedjira::Feed.fetch_and_parse "http://feeds.feedburner.com/uhhyeahdude/podcast"
    latest_entry = feed.entries.first

    title_match = /^Episode (\d*)/.match(latest_entry.title)
    episode_title = title_match[0]
    episode_number = title_match[1]
    episode = Episode.find_or_initialize_by(
      title: episode_title,
      number: episode_number,
      published_at: latest_entry.published
    )
    episode.public_url = latest_entry.image
    episode.description = latest_entry.summary
    if episode.save
      Sidekiq.logger.info "Episode #{episode_number} Was Creaated or Updated"
    else
      Sidekiq.logger.warn "Episode errored out: #{episode.errors.full_messages}"
    end
  end
end
