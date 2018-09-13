class User < ApplicationRecord
  has_secure_password
  has_many :cards
  has_many :store_users
  has_many :stores, through: :store_users
end
