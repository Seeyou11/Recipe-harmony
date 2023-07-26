class Role < ApplicationRecord
  has_and_belongs_to_many :users, dependent: :destroy
  has_and_belongs_to_many :permissions, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  
  # has_many :users

  def set_permissions(permission_ids)
    permissions << Permission.find(permission_ids)
  end
end
