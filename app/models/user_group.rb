class UserGroup < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  validates :user, :group, presence: true
  validates :group_id, uniqueness: { scope: :user_id }
  validates :balance, presence: true, numericality: {
    greater_than_or_equal_to: 0
  }
end
