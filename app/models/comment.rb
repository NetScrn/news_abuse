class Comment < ActiveRecord::Base
  validates_presence_of :content
  validates :content, length: {minimum: 10}
  belongs_to :author, class_name: "User"
  belongs_to :article
  has_ancestry
end
