class ZipCode < ApplicationRecord
  validates :value, presence: true
  belongs_to :state
end
