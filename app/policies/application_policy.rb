class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @current_user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  def rails_admin?(action)
    case action
      when :dashboard
        @current_user.admin?
      when :index
        @current_user.admin?
      when :show
        @current_user.admin?
      when :new
        @current_user.admin?
      when :edit
        @current_user.admin?
      when :destroy
        @current_user.admin?
      when :export
        @current_user.admin?
      when :history
        @current_user.admin?
      when :show_in_app
        @current_user.admin?
      else
        raise ::Pundit::NotDefinedError, "unable to find policy #{action} for #{record}."
    end
  end
end

