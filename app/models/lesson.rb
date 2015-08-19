class Lesson < ActiveRecord::Base
  belongs_to :category
  has_many :words

  validates :name, presence: true, length: {maximum: 50}
end
