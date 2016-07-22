class Article < ActiveRecord::Base
  belongs_to :author, class_name: "User"
  has_and_belongs_to_many :categories, uniq: true
  has_many :comments, dependent: :destroy

  validates_presence_of :title, :description, :categories
  validates :title, length: {minimum: 5}
  validates :description, length: {minimum: 20}
  validates :body, length: {minimum: 200}

  scope :confirmed, -> { where.not(confirmed_at: nil) }

  def confirm
    self.update_attributes(confirmed_at: Time.now)
    # TODO: add email notification about confirmation
  end

  def reject
    destroy
    # TODO add email notification about rejection
  end

  def confirmed?
    !!confirmed_at
  end
end
