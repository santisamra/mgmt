class MembersController < ApplicationController
  before_filter :authenticate_user!

  def index
    render json: Project.where(project_attributes).first.users, status: 200
  end

  def create
    project = Project.where(project_attributes).first
    user = User.where(login: params[:login]).first
    binding.pry
    if user.nil? || project.users.include?(user)
      render json: {}, status: 404
    else
      project.users << user
      render json: user, status: 200
    end
  end

  def destroy
    project = Project.where(project_attributes).first
    user = User.where(login: params[:user]).first

    if user.nil? and project.users.delete(user) 
      render json: {}, status: 200
    else 
      render json: {}, status: 422
    end
  end

  private

    def project_attributes
      {
        organization: organization_name,
        name: params[:project_id]
      }
    end
end
