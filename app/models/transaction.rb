class Transaction < ApplicationRecord
  belongs_to :profile
  validates :nature, inclusion: { in: %w[invoice payment],
                                message: 'Please choose "invoice" or "payment"' }
  validate :transaction_date_cannot_be_in_the_future
  validates :description, length: { maximum: 500 }

  def transaction_date_cannot_be_in_the_future
    if date.present? && date > Date.today
      errors.add(:date, "can't be in the future")
    end
  end
end
