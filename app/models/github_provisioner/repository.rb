module GithubProvisioner

  class Repository < SimpleDelegator

    def initialize(github, repository)
      @github = github
      super(repository)
    end

    def provide_issues!
      issues = @github.issues.list(user: organization, repo: name)
      self.issues_attributes = issues.map do |issue|
        { 
          number: issue.number,
          github_status: issue.state,
          created_at: issue.created_at,
          updated_at: issue.updated_at
        }
      end
      save!
    end

  end

end