class Feature < ApplicationRecord
  has_many :comments, foreign_key: 'feature_id', primary_key: 'feature_id'

  validates :feature_id, uniqueness: true
  validates :feature_id, :title, :url, :place, :mag_type, :coordinates, presence: true
  validate :validate_coordinates

  def validate_coordinates
    if coordinates.present? && coordinates['longitude'].present? && coordinates['latitude'].present?
      errors.add(:coordinates, "invalid coordinate latitude") unless coordinates['latitude'].between?(-180, 180)
      errors.add(:coordinates, "invalid coordinate longitude") unless coordinates['longitude'].between?(-90, 90)
    else
      errors.add(:coordinates, "coordinates missing")
    end
  end
end
