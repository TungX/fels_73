class Activity < ActiveRecord::Base
  belongs_to :user

  enum state: [:follow, :unfollow, :learnded, :learning, :begin_learn]

  validates :target_id, presence: true, numericality: {only_integer: true}
end
