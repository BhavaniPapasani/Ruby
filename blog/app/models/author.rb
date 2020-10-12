class Author
  include Mongoid::Document
  field :name, type: String
  field :age, type: Integer
  field :details, type: String
  has_many :posts
  field :_id, type: String, default: ->{ name }
end
