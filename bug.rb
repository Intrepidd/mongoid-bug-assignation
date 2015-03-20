require 'rubygems'
require 'bundler/setup'

require 'mongoid'

Mongoid.connect_to('bug_test')

class Author
  include Mongoid::Document

  field :name, type: String
end

class Post
  include Mongoid::Document

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
