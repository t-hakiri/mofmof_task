class Member < ApplicationRecord
  has_many :join_groups, dependent: :destroy
  has_many :members_in_groups, through: :join_groups, source: :group
end
