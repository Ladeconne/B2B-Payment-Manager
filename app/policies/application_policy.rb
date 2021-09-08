class ApplicationPolicy
  attr_reader :user, :record, :session

  def initialize(context, record)
    @context = context
    @record = record
  end

  delegate :user, to: :context
  delegate :session, to: :context
end
