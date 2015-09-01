class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  validates :follower_id, presence: true
  validates :followed_id, presence: true

  before_create :create_activity
  before_destroy :update_activity

  def create_activity
    follower.activities.create state: :follow, target_id: followed.id
  end

  def update_activity
    follower.activities.create state: :unfollow, target_id: followed.id
  end
end
