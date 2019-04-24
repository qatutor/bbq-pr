class User < ApplicationRecord
  has_many :events

  validate :name, presence: true, length: {maximum: 35}
  validate :email, presence: true, length: {maximum: 255}, uniqueness: true, format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ }
end
