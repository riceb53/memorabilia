class Card < ApplicationRecord
  belongs_to :user
  belongs_to :store
  has_many :stats
end
