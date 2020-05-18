class Group < ApplicationRecord
  has_many :join_groups, dependent: :destroy
  has_many :join_group_members, through: :join_groups, source: :member
end
