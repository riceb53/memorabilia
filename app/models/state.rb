class State < ApplicationRecord
  validates :name, uniqueness: true
  has_many :stores
  has_many :zip_codes
end
