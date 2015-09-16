# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :datetime         not null
#  end_date   :datetime         not null
#  status     :string           default("PENDING")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CatRentalRequest < ActiveRecord::Base
  STATUSES = %w(PENDING APPROVED DENIED)
  validates :cat_id, :start_date, :end_date, presence: true
  validates :status, inclusion: {in: STATUSES}
  validate  :no_overlapping_approved_requests
  validate :start_date_precedes_end_date
  belongs_to :cat

  def approve!
    return unless pending?
    CatRentalRequest.transaction do
      overlapping_requests.update_all(status: "DENIED")
      self.update(status: "APPROVED")
    end
  end

  def deny!
    self.update(status: "DENIED")
  end

  def pending?
    status == 'PENDING'
  end

  private
  def overlapping_requests
    @cat_rental_requests = CatRentalRequest.where(cat_id: cat_id)
        .where("start_date BETWEEN '#{start_date}' AND '#{end_date}' OR
                end_date BETWEEN '#{start_date}' AND '#{end_date}'")

  end

  def no_overlapping_approved_requests
    overlap = overlapping_requests.where(status: "APPROVED")
    unless overlap.empty?
      errors.add(:overlap, "cannot have overlapping requests")
    end
  end

 def start_date_precedes_end_date
    if start_date > end_date
      errors.add(:bad_date, "Cannot start after you end")
    end
  end
end
