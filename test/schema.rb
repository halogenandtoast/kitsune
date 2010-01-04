ActiveRecord::Base.establish_connection(
  :adapter => defined?(RUBY_ENGINE) && RUBY_ENGINE == 'jruby' ? 'jdbcsqlite3' : 'sqlite3',
  :database => File.join(File.dirname(__FILE__), 'test.db')
)

class CreateSchema < ActiveRecord::Migration
  def self.up
    create_table :posts, :force => true do |t|
      t.string :title
      t.text :body
      t.timestamps
    end
  end
end
 
CreateSchema.suppress_messages do
  CreateSchema.migrate(:up)
end

class Post < ActiveRecord::Base
  admin do
  end
end