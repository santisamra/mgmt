class IssuesController < ApplicationController
  before_filter :authenticate_user!
  inherit_resources
  respond_to :json
  action :update

  def log_worked_hours
    issue = Issue.find(params[:id])
    logger = WorkedHoursLogger.new(current_user)
    logger.log_worked_hours(params[:worked_hours], issue)
    render json: {}, status: 200
  end
  
  private

    def resource_params
      [] if request.get?
      [params.require(:issue).permit(:estimated_hours, :issue_type, :status)]
    end

end