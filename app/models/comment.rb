class Comment < ActiveRecord::Base
  validates_presence_of :content
  validates :content, length: {minimum: 10}
  belongs_to :author, class_name: "User"
  belongs_to :article
  has_many :subcomments, class_name: "Comment", foreign_key: "comment_id"
  belongs_to :parent_comment, class_name: "Comment", foreign_key: "comment_id"
end
