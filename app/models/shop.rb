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
  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :shop_features, dependent: :destroy
  has_many :features, through: :shop_features
  has_many_attached :images

  validates :name, presence: true, length: { maximum: 255 }
  validates :address, presence: true, uniqueness: true, length: { maximum: 255 }
  geocoded_by :address
  validates :phone, length: { maximum: 20 }
  validates :opening, length: { maximum: 255 }
  validates :closed, length: { maximum: 255 }
  validates :images, content_type: { in: %w[image/jpeg image/gif image/png],
                                     message: "無効なファイル形式です" },
                     size: { less_than: 5.megabytes,
                             message: "サイズは5MB以下にしてください" },
                     limit: { max: 3, message: "投稿できるのは最大3枚です" }

  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end
end
