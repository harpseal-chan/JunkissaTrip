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
  validates :name, presence: true, length: { maximum: 255 }
  validates :address, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :phone, length: { maximum: 20 }
  validates :opening, length: { maximum: 255 }
  validates :closed, length: { maximum: 255 }
end
