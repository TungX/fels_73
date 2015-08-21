class Word < ActiveRecord::Base
  belongs_to :category
  has_many :answers, dependent: :destroy

  mount_uploader :image, ImageUploader
  mount_uploader :sound, SoundUploader

  validates :content, presence: true, length: {maximum: 50}, uniqueness: {case_sensitive: false}
end
