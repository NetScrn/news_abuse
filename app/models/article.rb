class Article < ActiveRecord::Base
  belongs_to :author, class_name: "User"
  has_and_belongs_to_many :categories, uniq: true, depenent: :destroy
  validates_presence_of :title, :description
  validates :title, length: {minimum: 5}
  validates :description, length: {minimum: 20}
  validates :body, length: {minimum: 200}
end
