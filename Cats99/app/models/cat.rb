# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :datetime         not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Cat < ActiveRecord::Base
  COLORS = ["white", "black", "purple"]
  SEXES = %w(m f)

  validates :birth_date, :color, :name, :sex, presence: true
  validates :color, inclusion: { in: COLORS }
  validates :sex, inclusion: { in: SEXES }

  has_many :cat_rental_requests, :dependent => :destroy

  def age
    Time.now.year - birth_date.year
  end
end
