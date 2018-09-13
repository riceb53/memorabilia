class Store < ApplicationRecord
  belongs_to :state
  has_many :cards
  has_many :store_users
  has_many :users, through: :store_users
end
