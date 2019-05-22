class Comment < ApplicationRecord
  belongs_to :feature, foreign_key: 'feature_id', primary_key: 'feature_id'
  validates :feature_id, :email, :body, presence: true
end
