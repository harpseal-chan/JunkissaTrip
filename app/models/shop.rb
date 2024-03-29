# == Schema Information
#
# Table name: shops
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  address    :string           not null
#  phone      :string
#  opening    :string
#  closed     :string

class Shop < ApplicationRecord
  acts_as_mappable default_units: :kms,
                   lat_column_name: :latitude,
                   lng_column_name: :longitude

  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :shop_features, dependent: :destroy
  has_many :features, through: :shop_features
  has_many_attached :images

  validates :name, presence: true, length: { maximum: 255 }
  validates :kana, presence: true, length: { maximum: 255 }
  validates :address, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :longitude, presence: true
  validates :latitude, presence: true
  validates :phone, length: { maximum: 20 }
  validates :opening, length: { maximum: 255 }
  validates :closed, length: { maximum: 255 }
  validates :smoking, length: { maximum: 255 }
  validates :payment, length: { maximum: 255 }
  validates :access, length: { maximum: 255 }
  validates :images, content_type: { in: %w[image/jpeg image/gif image/png],
                                     message: "無効なファイル形式です" },
                     size: { less_than: 5.megabytes,
                             message: "サイズは5MB以下にしてください" },
                     limit: { max: 3, message: "投稿できるのは最大3枚です" }

  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[address name]
  end

  def self.ransackable_associations(_auth_object = nil)
    ["features"]
  end
end
