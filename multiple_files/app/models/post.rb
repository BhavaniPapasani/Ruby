class Post
  include Mongoid::Document
  field :title, type: String
  has_many :post_attachments, dependent: :destroy
end
