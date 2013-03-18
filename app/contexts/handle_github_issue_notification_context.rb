class HandleIssueGithubNotificationContext

  def initialize(github_issue, project)
    @github_issue = OpenStruct.new(github_issue)
    @project = project
  end

  def handle_issue
    raise ArgumentError, "Project cannot be nil" unless @project
    issue = Issue.where(number: @github_issue.number, project_id: @project.id).first
    if issue
      issue.update_attributes!(github_status: @github_issue.state)
      issue
    else
      issue_attributes = GithubProvisioner::Issue.extract_attributes(@github_issue)
      issue_attributes[:project_id] = @project.id
      Issue.create!(issue_attributes)
    end
  end

end