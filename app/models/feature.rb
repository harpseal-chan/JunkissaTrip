class Feature < ApplicationRecord
  validates :icon_name, presence: true, length: { maximum: 50 }
  validates :detail, presence: true, length: { maximum: 255 }
end
