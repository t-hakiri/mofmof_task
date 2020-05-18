class Member < ApplicationRecord
  has_many :join_groups, dependent: :destroy
end
