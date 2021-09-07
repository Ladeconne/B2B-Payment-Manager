class Profile < ApplicationRecord
  has_many :transactions, dependent: :destroy
  belongs_to :user
end
