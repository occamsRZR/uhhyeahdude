class EpisodesController < InheritedResources::Base
  has_scope :by_number, default: :asc, allow_blank: true, only: :index
end
