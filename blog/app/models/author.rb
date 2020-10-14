class Author
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated
  field :name, type: String
  field :age, type: Integer
  field :details, type: String
  field :_id, type: String, default: ->{ name }
  has_many :posts
end
