class Category < ActiveRecord::Base
  has_many :lessons, dependent: :destroy
  has_many :words, dependent: :destroy

  validates :name,  presence: true, length: {maximum: 50}, uniqueness: {case_sensitive: false}
  validates :description,  presence: true, length: {maximum: 140}

  before_save :make_slug

  def to_param
    slug
  end

  private
  def make_slug
    self.slug = self.name.downcase.gsub(" ", "-")
  end
end
