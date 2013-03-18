module GithubProvisioner

  class Repository < SimpleDelegator

    def initialize(github, project)
      @github = github
      super(project)
    end

    def provide_issues!
      issues = @github.issues.list(user: organization, repo: name)
      self.issues_attributes = issues.map do |issue|
        GithubProvisioner::Issue.extract_attributes(issue)
      end
      save!
    end

  end

end