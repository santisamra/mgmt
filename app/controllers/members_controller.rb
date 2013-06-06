class MembersController < ApplicationController
  before_filter :authenticate_user!

  def index
    render json: { members: Project.where(project_attributes).first.users }, status: 200
  end

  def add
    project = Project.where(project_attributes).first
    user = User.where(login: params[:user]).first
    binding.pry
    if user.nil? || project.users.include?(user)
      render json: {}, status: 404
    else
      project.users << user
      render json: user, status: 200
    end
  end

  def delete
    project = Project.where(name: params[:id]).first
    user = User.where(login: params[:user]).first

    project.users.delete(user) unless user.nil?
    redirect_to project_path(project.name)
  end

  private

    def project_attributes
      {
        organization: organization_name,
        name: params[:project_id]
      }
    end
end
