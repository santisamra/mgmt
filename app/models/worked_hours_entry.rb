class WorkedHoursEntry < ActiveRecord::Base

  # Associations

  belongs_to :user
  belongs_to :issue

  # Validations

  validates :user_id, uniqueness: { scope: :issue_id }
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validates :date, presence: true
  validate :date_cannot_be_in_the_future

  # Class Methods

  def self.today(user, issue)
    where(user_id: user.id, issue_id: issue.id, date: Date.today).first 
  end

  # Instance Methods

  private

    def date_cannot_be_in_the_future
      if date > Date.today
        error.add(:date, t("models.worked_hours_entry.future_date"))
      end
    end

end
