class Group < ActiveRecord::Base
  validates :user_id, presence: true
  validates :name, presence: true

  belongs_to :user

  has_many :group_contacts

  has_many :contacts,
    through: :group_contacts,
    source: :contacts
end
