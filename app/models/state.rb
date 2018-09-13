class State < ApplicationRecord
  has_many :stores
  has_many :zip_codes
end
