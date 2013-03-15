require 'spec_helper'

describe WorkedHoursLogger do

  let(:project)    { create(:project) }
  let(:issue)      { create(:issue, project: project) }
  let(:user)       { create(:user) }
  subject(:logger) { WorkedHoursLogger.new(user) }

  describe "#log_worked_hours" do

    context "when the user has never logged hours for the issue" do

      it "creates a new WorkedHoursEntry" do
        expect { logger.log_worked_hours(1, issue) }.to change { issue.worked_hours_entries.count }.by 1
      end

      it "does not allows negative hours" do
        expect { logger.log_worked_hours(-1, issue) }.to raise_error ArgumentError
      end

    end

    context "when the user has logged hours for the issue" do

      before(:all) { logger.log_worked_hours(2, issue) }

      it "updates the existing WorkedHoursEntry" do
        expect { logger.log_worked_hours(1, issue) }.to change { WorkedHoursEntry.where(issue_id: issue.id).first.amount }.by 1
      end

      it "returns the total amount of worked hours for the issue" do
        logger.log_worked_hours(1, issue).should eq issue.worked_hours
      end

      context "when the user reports negatives hours" do

        it "updates the existing WorkedHoursEntry" do
          expect { logger.log_worked_hours(-1, issue) }.to change { WorkedHoursEntry.where(issue_id: issue.id).first.amount }.by -1
        end

        context "when the negative hours are greter than the worked hours" do

          it "updates the existing WorkedHoursEntry to 0" do
            logger.log_worked_hours(-10, issue)
            WorkedHoursEntry.where(issue_id: issue.id).first.amount.should eq 0
          end

        end

      end

    end

  end

end