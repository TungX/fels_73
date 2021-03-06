class Activity < ActiveRecord::Base
  belongs_to :user

  enum state: [:follow, :unfollow, :learned, :learning]

  validates :target_id, presence: true, numericality: {only_integer: true}

  scope :all_activities_by, ->user_id{where("user_id in (select followed_id from
    relationships where follower_id = #{user_id}) or user_id = #{user_id}")
    .order("created_at DESC")}

  def load_user
    User.find_by id: self.target_id
  end

  def load_lesson
    Lesson.find_by id: self.target_id
  end
end
