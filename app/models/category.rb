class Category < ActiveRecord::Base
  has_many :lessons, dependent: :destroy
  has_many :words, dependent: :destroy

  validates :name,  presence: true, length: {maximum: 50}, uniqueness: {case_sensitive: false}
  validates :description,  presence: true, length: {maximum: 140}

  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
end
