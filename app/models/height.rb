class Height < ApplicationRecord
  scope :from_user, -> (user) { where user: user }

  belongs_to :user
  validates :measurement, presence: true, numericality: true, inclusion: 0..3
  validates :measured_at, presence: true, date: true
end
