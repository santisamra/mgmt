require 'spec_helper'

describe Issue do

  let(:project)   { create(:project) }
  subject(:issue) { create(:issue, project: project) }

  describe "#worked_hours" do
    
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }

    before(:all) do 
      create(:worked_hours_entry, user: user1, issue: issue)
      create(:worked_hours_entry, user: user2, issue: issue)
    end 

    it "returns the sum of all the worked hours" do
      issue.worked_hours.should eq 2
    end

  end

end
