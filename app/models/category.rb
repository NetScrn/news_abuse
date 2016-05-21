class Category < ActiveRecord::Base
  has_and_belongs_to_many :articles, uniq: true, depenent: :destroy
  validates_presence_of :name
end
