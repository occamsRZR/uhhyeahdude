class EpisodeDownloadWorker
  include Sidekiq::Worker
  sidekiq_options queue: :downloader, retry: true, backtrace: true

  def perform(episode_id)
    episode = Episode.find(episode_id)
    episode.download_episode
  end
end
