class Job < ApplicationRecord

  validates :company, presence: true
  validates :description, presence: true
  validates :position, presence: true
end