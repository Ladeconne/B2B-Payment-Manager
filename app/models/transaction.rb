class Transaction < ApplicationRecord
  belongs_to :profile
  validates :type, inclusion: { in: %w[invoice payment],
                                message: 'Please choose "invoice" or "payment"' }
  validates :expiration_date_cannot_be_in_the_past
  validates :description, length: { maximum: 500 }

  def expiration_date_cannot_be_in_the_past
    if expiration_date.present? && expiration_date <= Date.today
      errors.add(:expiration_date, "can't be in the past")
    end
  end
end
