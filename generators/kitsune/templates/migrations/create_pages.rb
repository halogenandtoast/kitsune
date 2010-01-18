class KitsuneCreatePages < ActiveRecord::Migration
  def self.up
    create_table(:pages) do |t|
      t.string :title
      t.string :url
      t.string :layout
      t.text :body
      t.integer :parent_id
      t.text :data
    end
  end
  
  def self.down
    drop_table :pages
  end
end