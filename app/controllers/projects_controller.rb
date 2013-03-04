class ProjectsController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def show
    @project = project
    unless @project
      @project = GithubProvisioner::Repository.new(current_user.github, create_project)
      @project.provide_issues!
    end
  end

  private

    def project_attributes
      {
        organization: organization_name,
        name: params[:id]
      }
    end

    def project
      Project.where(project_attributes).first
    end

    def create_project
      Project.create!(project_attributes)
    end

end
