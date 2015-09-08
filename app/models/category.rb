class Category < ActiveRecord::Base
  has_many :lessons, dependent: :destroy
  has_many :words, dependent: :destroy

  validates :name,  presence: true, length: {maximum: 50}, uniqueness: {case_sensitive: false}
  validates :description,  presence: true, length: {maximum: 140}

  before_save :make_slug
  after_destroy :destroy_activities

  def to_param
    slug
  end

  private
  def make_slug
    self.slug = self.name.downcase.gsub(" ", "-")
  end

  def destroy_activities
    Activity.by_category(self.id).destroy_all
  end
end
