class PostAttachment
  include Mongoid::Document
  field :post_id, type: Integer
  field :avatar, type: String
  mount_uploader :avatar, AvatarUploader
  belongs_to :post
end
