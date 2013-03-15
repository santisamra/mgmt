class CreateWorkedHoursEntries < ActiveRecord::Migration
  def change
    create_table :worked_hours_entries do |t|
      t.decimal     :amount
      t.references  :user
      t.references  :issue
      t.date        :date
    end

    add_index :worked_hours_entries, :user_id
    add_index :worked_hours_entries, :issue_id
    add_index :worked_hours_entries, :date
  end
end
