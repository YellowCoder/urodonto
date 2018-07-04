module WithCurrentUser
  extend ActiveSupport::Concern

  def with_current_user(record)
    record.user = current_user
    record
  end
end