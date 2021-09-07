class Profile < ApplicationRecord
  has_many :transactions, dependent: :destroy
end
