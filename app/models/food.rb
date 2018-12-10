class Food < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: { maximum: 50 }
  validates :calories, presence: true, numericality: { only_integer: true }, inclusion: 0..5_000
  validates :occurred_at, presence: true, date: true
end
