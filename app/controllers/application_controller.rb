class ApplicationController < ActionController::Base
  protect_from_forgery


  protected
  
    def organization_name
      Rails.application.config.github['organization']
    end

end
