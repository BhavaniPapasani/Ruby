class Post
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated
  field :title, type: String
  field :genre, type: String
  field :author, type: String
  field :description, type: String
  field :pages, type: Integer
  validates_presence_of :title
  belongs_to :author, :optional => true
end
