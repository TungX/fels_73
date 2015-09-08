class Answer < ActiveRecord::Base
  belongs_to :word
  has_many :lesson_words, dependent: :destroy

  validates :content, presence: true, length: {maximum: 50}

  scope :corrects, ->lesson_id{where("id in (select answer_id from lesson_words where
    lesson_id = #{lesson_id}) and is_correct = 't'")}
end
