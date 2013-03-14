module ApplicationHelper

  def organization
    AppConfiguration[:github].organization
  end

end
