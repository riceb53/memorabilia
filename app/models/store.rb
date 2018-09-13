class Store < ApplicationRecord
  has_secure_password
  belongs_to :state
  has_many :cards
  has_many :store_users
  has_many :users, through: :store_users
end
