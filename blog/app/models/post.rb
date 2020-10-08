class Post
  include Mongoid::Document
  field :title, type: String
  field :genre, type: String
  field :description, type: String
  field :pages, type: Integer
end
