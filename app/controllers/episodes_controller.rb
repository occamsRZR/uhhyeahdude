class EpisodesController < InheritedResources::Base
  has_scope :by_number, default: :asc, allow_blank: true, only: :index
  has_scope :page
  
  protected
    def collection
      @episodes ||= end_of_association_chain.page(params[:page])
    end
end
