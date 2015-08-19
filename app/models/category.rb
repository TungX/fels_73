class Category < ActiveRecord::Base
  has_many :lessons

  validates :name,  presence: true, length: {maximum: 50}, uniqueness: {case_sensitive: false}
  validates :description,  presence: true, length: {maximum: 140}
end
