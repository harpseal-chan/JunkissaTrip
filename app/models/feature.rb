class Feature < ApplicationRecord
  has_many :shop_features, dependent: :destroy
  has_many :shops, through: :shop_features

  validates :icon_name, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :detail, presence: true, length: { maximum: 255 }, uniqueness: true
end