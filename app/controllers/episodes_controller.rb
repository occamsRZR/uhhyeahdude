class EpisodesController < InheritedResources::Base
  has_scope :by_number, default: :asc, allow_blank: true, only: :index
  has_scope :page

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
