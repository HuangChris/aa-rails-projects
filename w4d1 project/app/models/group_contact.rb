class GroupContact < ActiveRecord::Base
  validates :group_id, presence: true
  validates :contact_id, presence: true

  belongs_to :group

  belongs_to :contact
end
