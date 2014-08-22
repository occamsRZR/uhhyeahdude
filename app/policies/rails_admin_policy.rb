class RailsAdminPolicy < ApplicationPolicy
  def initialize(user, record=nil)
    super
  end

  def rails_admin?(action)
    case action
    when :dashboard
      true
    else
      super
    end
  end
end
