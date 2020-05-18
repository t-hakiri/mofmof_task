class Group < ApplicationRecord
  has_many :join_groups, dependent: :destroy
end
