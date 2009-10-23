class KitsuneCreatePages < ActiveRecord::Migration
  def self.up
    create_table(:pages) do |t|
      t.string :title
      t.string :url
      t.text :body
      t.integer :parent_id
    end
  end
  
  def self.down
    drop_table :pages
  end
end