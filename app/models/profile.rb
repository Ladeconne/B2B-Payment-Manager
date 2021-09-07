class Profile < ApplicationRecord
  has_many :transactions, dependent: :destroy
  has_many :users
end
