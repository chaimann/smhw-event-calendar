class Event < ApplicationRecord
  validates :title, :start, :end, presence: true
end
