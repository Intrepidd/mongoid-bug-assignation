require 'rubygems'
require 'bundler/setup'

require 'sqlite3'
require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter  => "sqlite3",
  :database => "/tmp/testdb.db"
)

class TestMigration < ActiveRecord::Migration
  def up
    create_table :authors do |t|
      t.string :name
    end

    create_table :posts do |t|
      t.references :author
    end
  end
end

TestMigration.migrate(:up)

class Author < ActiveRecord::Base
end

class Post < ActiveRecord::Base
  belongs_to :author
end

author1 = Author.create!(name: 'First author')
author2 = Author.create!(name: 'Second author')
post = Post.create!(author: author1)

a1 = post.author
puts a1.name
puts a1.object_id
post.author = author2
puts a1.name
puts a1.object_id

