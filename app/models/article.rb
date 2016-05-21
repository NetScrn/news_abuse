class Article < ActiveRecord::Base
  has_and_belongs_to_many :categories, uniq: true, depenent: :destroy
  validates_presence_of :title, :description
end
