class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :shop

  validates_uniqueness_of :shop_id, scope: :user_id
end
