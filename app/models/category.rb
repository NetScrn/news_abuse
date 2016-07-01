class Category < ApplicationRecord
  has_and_belongs_to_many :articles, -> { order(created_at: :desc) },
    uniq: true
  validates_presence_of :name
  validates :name, length: {minimum: 2}
end
