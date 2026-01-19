class ExampleJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    Rails.logger.info "Background job executing for #{user.email}"
    # Add additional job logic here
    # future: e.g., sending emails, notifications, heavy processing, etc.
  end
end
