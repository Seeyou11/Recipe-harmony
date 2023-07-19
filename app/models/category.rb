class Category < ApplicationRecord
  belongs_to :user
  has_many :recipes, dependent: :destroy
  validates :name, presence: true, uniqueness: true,  length: { minimum: 3, maximum: 25 }
  validates :description,  length: {minimum: 6, maximum: 100}
end
