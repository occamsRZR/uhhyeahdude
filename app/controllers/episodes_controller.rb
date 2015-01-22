class EpisodesController < InheritedResources::Base
  custom_actions resource: [:dope, :nope]
  after_filter :punch, only: :show
  has_scope :by_number, default: :asc, allow_blank: true, only: :index
  has_scope :by_topic
  has_scope :search
  has_scope :page

  def dope
    dope! do |format| 
      current_user.likes @episode
      format.html {redirect_to :back}
    end
  end

  def nope
    nope! do |format|
      current_user.dislikes @episode
      format.html {redirect_to :back}
    end
  end

  def punch
    @episode.punch(request)
  end

  def annotate
    if resource.episode_timestamps.create(timestamp: params[:timestamp], description: params[:description]).persisted?
      render json: nil, status: :ok
    else
      render json: nil, status: :unprocessable_entity
    end
  end
  
  protected
    def collection
      @episodes ||= end_of_association_chain.page(params[:page])
    end
end
