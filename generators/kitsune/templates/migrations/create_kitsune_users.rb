class KitsuneCreateKitsuneUsers < ActiveRecord::Migration
  def self.up
    create_table(:kitsune_users) do |t|
      t.string :email
      t.string :encrypted_password
      t.string :username
      t.string :salt
      t.string :remember_token
    end
  end
  
  def self.down
    drop_table :kitsune_users
  end
end