class Height < ApplicationRecord
  belongs_to :user
  validates :measurement, presence: true, numericality: true, inclusion: 0..3
  validates :measured_at, presence: true
end
