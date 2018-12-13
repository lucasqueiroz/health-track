class User < ApplicationRecord
  has_many :heights, dependent: :destroy
  has_many :weights, dependent: :destroy
  has_many :workouts, dependent: :destroy
  has_many :foods, dependent: :destroy

  validates :name, presence: true, length: { maximum: 100 }
  validates :email, presence: true, length: { maximum: 200 }, uniqueness: true, email: true
  validates :birthday, presence: true, date: { before: Date.new(2005, 1, 1) }

  has_secure_password
end
