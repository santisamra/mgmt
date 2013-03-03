module ApplicationHelper

  def organization
    Rails.application.config.github['organization']
  end

end
