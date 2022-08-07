class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :shop

  validates :user_id, presence: true
  validates :shop_id, presence: true
  validates :content, presence: true, length: { maximum: 400 }
end
