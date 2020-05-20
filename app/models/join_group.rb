class JoinGroup < ApplicationRecord
  belongs_to :member
  belongs_to :group

  scope :organizer_id, -> {find_by(organizer: true).member_id}
end
