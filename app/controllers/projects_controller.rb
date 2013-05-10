class ProjectsController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def show
    @project = Project.where(project_attributes).first
    unless @project
      # XXX This should be done async and the web page shoud check
      # against the server to know when the project has been created.
      callback_url = issues_github_notifications_url(organization_name, params[:id])
      @project = CreatingNewProjectContext.new({
        user: current_user, 
        project_attributes: project_attributes, 
        notifications_callback_url: callback_url,
        subscribe_to_events: Rails.application.config.github.subscribe_to_events
      }).create
    end
  end

  def add_user
    @project = Project.where(project_attributes).first
    @user = User.where(login: params[:user]).first

    if @user.nil? || @project.users.include?(@user)
      render json: {}, status: 404
    else
      @project.users << @user
      render json: @user, status: 200
    end 
  end

  def delete_user
    @project = Project.where(name: params[:id]).first
    @user = User.where(login: params[:user]).first

    @project.users.delete(@user) unless @user.nil?
    redirect_to project_path(@project.name)
  end

  private

    def project_attributes
      {
        organization: organization_name,
        name: params[:id]
      }
    end

end
