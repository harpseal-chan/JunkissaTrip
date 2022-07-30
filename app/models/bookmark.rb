class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :shop

  validates :user_id, presence: true
  validates_uniqueness_of :shop_id, scope: :user_id, presence: true
end
