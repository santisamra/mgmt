class ApplicationController < ActionController::Base
  protect_from_forgery


  protected
  
    def organization_name
      AppConfiguration[:github].organization
    end

end
