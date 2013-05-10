module GithubProvisioner

  module Issue

    class << self

      def extract_attributes(github_issue)
        { 
          number: github_issue.number,
          github_status: github_issue.state,
          milestone_number: github_issue.milestone.number,
          created_at: github_issue.created_at,
          updated_at: github_issue.updated_at
        }
      end

    end

  end

end