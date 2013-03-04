class Issue < ActiveRecord::Base
  STATUS = %w(
    not_started
    started
    finished
    accepted
    rejected
    delivered
  )
  TYPE = %w(
    chore
    feature
    bug
  )

  # Validations

  validates_presence_of :number
  validates_presence_of :project
  validates :status, inclusion: { in: STATUS }
  validates :issue_type, inclusion: { in: TYPE }

  # Associations

  belongs_to :project

end
