module GithubProvisioner

  module Issue

    class << self

      def extract_attributes(github_issue)
        extracted_attributes = { 
          number: github_issue.number,
          github_status: github_issue.state,
          created_at: github_issue.created_at,
          updated_at: github_issue.updated_at
        }
        extracted_attributes[:milestone_number] = github_issue.milestone.number if github_issue.milestone
        extracted_attributes
      end

    end

  end

end