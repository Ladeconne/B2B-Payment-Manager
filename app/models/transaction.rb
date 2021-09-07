class Transaction < ApplicationRecord
  belongs_to :profile
  validates :nature, inclusion: { in: %w[invoice payment],
                                message: 'Please choose "invoice" or "payment"' }
  validate :expiration_date_cannot_be_in_the_past
  validates :description, length: { maximum: 500 }

  def expiration_date_cannot_be_in_the_past
    if date.present? && date > Date.today
      errors.add(:date, "can't be in the future")
    end
  end
end
