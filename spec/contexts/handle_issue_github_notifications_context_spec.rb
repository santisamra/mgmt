require 'spec_helper'

describe HandleIssueGithubNotificationContext do

  let(:project) { create(:project) }
  let(:issue)   do 
    json_file_path = File.join(fixture_path, 'issue_event_payload.json')
    payload = JSON.parse(File.read(json_file_path))
    payload['issue']
  end

  describe "#handle_issue" do

    context "when the issue already exists" do

      before(:all) do 
        create(:issue, project: project)
        issue[:number] = Issue.first.number
        issue[:state] = 'closed'
      end

      it "updates the issue github_status attribute" do
        context = HandleIssueGithubNotificationContext.new(issue, project)
        context.handle_issue
        Issue.first.github_status.should eq 'closed'
      end

    end

    context "when the issue does not exists" do

      before(:all) do 
        issue[:state] = 'open'
      end

      it "creates a new issue" do
        context = HandleIssueGithubNotificationContext.new(issue, project)
        expect { context.handle_issue }.to change { Issue.count }.by 1
      end

    end

  end

end