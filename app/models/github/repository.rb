module Github

  class Repository < SimpleDelegator

    def initialize(github, repository)
      @github = github
      super(repository)
    end

    def from_github!
      issues = @github.issues.list(organization, name)
      self.issues_attributes = issues.map do |issue|
        { number: issue.number }
      end
      save!
    end

  end

end