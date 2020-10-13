class Post
  include Mongoid::Document
  field :title, type: String
  field :genre, type: String
  field :author, type: String
  field :description, type: String
  field :pages, type: Integer
  validates_presence_of :title
  belongs_to :author, :optional => true
end
