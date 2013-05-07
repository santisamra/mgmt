module GithubProvisioner

  class Repository < SimpleDelegator

    def initialize(github, project)
      super(project)
      @github = github
      @project = project
    end

    def provide_issues!
      self.issues_attributes = fetch_parsed_issues
      save!
    end

    def sync_issues!
      gh_issues = fetch_parsed_issues(:all)
      transaction do
        gh_issues.each { |issue| sync_issue(issue) }
      end
    end

    private

      def fetch_issues(state)
        if state == :all
          fetch_issues(:closed).to_a + fetch_issues(:open).to_a
        else
          options = {
            user: organization, 
            repo: name, 
            state: state.to_s
          }
          result = []
          @github.issues.list(options).each_page { |page| result << page.to_a }
          result.flatten
        end
      end

      def fetch_parsed_issues(state = :open)
        fetch_issues(state).map do |issue|
          GithubProvisioner::Issue.extract_attributes(issue)
        end
      end

      def sync_issue(gh_issue)
        puts "syncing issue #{gh_issue}"
        issue = self.issues.where(number: gh_issue[:number]).first
        if issue.nil?
          ::Issue.create!(gh_issue.merge(project: @project))
        elsif issue.github_status != gh_issue[:github_status]
          issue.update_attributes!(github_status: gh_issue[:github_status])
        end
      end

  end

end