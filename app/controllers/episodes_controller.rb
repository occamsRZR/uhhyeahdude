class EpisodesController < ApplicationController
  respond_to :html, :jsonp
  custom_actions resource: [:dope, :nope]
  after_filter :punch, only: :show
  has_scope :by_number, default: :asc, allow_blank: true, only: :index
  has_scope :by_topic
  has_scope :search
  has_scope :page

  def dope
    dope! do |format| 
      if current_user
        current_user.likes @episode
        format.html {redirect_to :back}
      else
        flash[:error] = "You must login before voting!"
        format.html {redirect_to :back}
      end
    end
  end

  def nope
    nope! do |format|
      if current_user
        current_user.dislikes @episode
        format.html {redirect_to :back}
      else
        flash[:error] = "You must login before voting!"
        format.html {redirect_to :back}
      end
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
