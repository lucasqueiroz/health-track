class Weight < ApplicationRecord
  belongs_to :user
  validates :measurement, presence: true, numericality: true, inclusion: 20..500
  validates :measured_at, presence: true, date: true
end
