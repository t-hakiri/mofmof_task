class JoinGroup < ApplicationRecord
  belongs_to :member
  belongs_to :group
end
