module ApplicationHelper

  def can_vote
    unless current_user
      'disabled'
    end
  end

  def dopest_episodes(number)
    Episode.order(cached_votes_total: :desc).limit(number)
  end
  
  def nopest_episodes(number)
    Episode.order(cached_votes_total: :asc).limit(number)
  end

  def most_popular_episodes(number)
    Episode.most_hit(1.week.ago, number)
  end
end
