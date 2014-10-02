module ApplicationHelper

  def can_vote
    unless current_user
      'disabled'
    end
  end

  def dopest_five_episodes
    Episode.order(cached_votes_total: :desc).limit(5)
  end

  def nopest_five_episodes
    Episode.order(cached_votes_total: :asc).limit(5)
  end
end
