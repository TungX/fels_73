class Lesson < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :lesson_words, dependent: :destroy
  has_many :words, through: :lesson_words

  accepts_nested_attributes_for :lesson_words

  before_create :create_words, :create_activity_when_create
  before_update :create_activity_when_update

  private
  def create_words
    self.words = self.category.words.order("RANDOM()").limit Settings.number_word_in_lessons
  end

  def create_activity_when_create
    Activity.create state: :learning, target_id: self.id, user_id: self.user.id
  end

  def create_activity_when_update
    Activity.create state: :learned, target_id: self.id, user_id: self.user.id
  end
end
