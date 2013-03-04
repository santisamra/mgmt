class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.string :organization
      t.string :name

      t.timestamps
    end

    add_index :repositories, [:organization, :name]
  end
end
