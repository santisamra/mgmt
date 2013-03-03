class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      ## User fields
      t.string   :email
      t.string   :name
      t.string   :login
      t.string   :token
      t.string   :organization_avatar
      t.string   :gravatar_id

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Omniauth
      t.string   :provider
      t.string   :uid

      t.timestamps
    end

    add_index :users, [:provider, :uid], unique: true
  end
end
