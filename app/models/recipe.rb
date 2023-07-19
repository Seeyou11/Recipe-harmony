class Recipe < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many_attached :images
  validates :title, presence: true, length: { minimum: 6, maximum: 100 }
  validates :description, presence: true, length: { minimum: 10, maximum: 300 }
  validates :preparation_steps, presence: true, length: { minimum: 10, maximum: 300 }
  validates :images, presence: true, blob: { content_type: :image }

  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
end
