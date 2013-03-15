class WorkedHoursLogger < SimpleDelegator

  def initialize(user)
    super
    @user = user
  end

  def log_worked_hours(hours, issue)
    transaction do
      entry = WorkedHoursEntry.today(@user, issue)
      if entry
        amount = entry.amount + hours
        amount = 0 if amount < 0
        entry.update_attributes!(amount: amount)
        amount
      else
        raise ArgumentError, "Hours must be positive" if hours < 0
        WorkedHoursEntry.create!(user: @user, issue: issue, amount: hours, date: Date.today)
        hours
      end
    end
  end

end