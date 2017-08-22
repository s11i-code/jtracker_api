class Location < ApplicationRecord

  validates :longitude, presence: true
  validates :latitude, presence: true
  validates :name, presence: true

  has_many :starting_journeys, class_name: 'Journey', foreign_key: 'origin_id'
  has_many :ending_journeys, class_name: 'Journey', foreign_key: 'destination_id'
end
