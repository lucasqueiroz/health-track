class User < ApplicationRecord
  has_many :heights
  has_many :weights
  has_many :workouts
  has_many :foods

  validates :name, presence: true, length: { maximum: 100 }
  validates :email, presence: true, length: { maximum: 200 }, uniqueness: true, email: true
  validates :birthday, presence: true, date: { before: Date.new(2005, 1, 1) }

  has_secure_password
end
