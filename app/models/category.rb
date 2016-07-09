class Category < ActiveRecord::Base
  has_and_belongs_to_many :articles, -> { order(created_at: :desc) },
    uniq: true
  validates :name, presence: true, length: {minimum: 2}
end
