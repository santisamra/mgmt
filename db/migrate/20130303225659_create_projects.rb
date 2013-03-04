class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :organization
      t.string :name

      t.timestamps
    end

    add_index :projects, [:organization, :name], unique: true
  end
end
