class EpisodeTimestamp < ActiveRecord::Base
  belongs_to :episode
  default_scope { order(timestamp: :asc) }

  def display_timestamp
    mm, ss = timestamp.divmod(60)
    hh, mm = mm.divmod(60)
    "#{hh.to_s.rjust(2, '0')}:#{mm.to_s.rjust(2, '0')}:#{ss.to_s.rjust(2, '0')}"
  end
end
