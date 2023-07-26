class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  
  has_many :recipes, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_one_attached :profile_pic, dependent: :destroy
 
  has_and_belongs_to_many :roles, join_table: :roles_users

  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :follow_requests, -> {where(accepted: false) }, class_name: "Follow", foreign_key: "followed_id"
  # followers 
  has_many :accepted_recieved_requests, -> {where(accepted: true) }, class_name: "Follow", foreign_key: "followed_id"
  #  followings
  has_many :accepted_sent_requests, -> {where(accepted: true) }, class_name: "Follow", foreign_key: "follower_id"

  # has_many :recieved_requests, class_name: "Follow", foreign_key: "followed_id"
  # has_many :sent_requeasts, class_name: "Follow", foreign_key: "follower_id"
  
  has_many :waiting_sent_requests, -> {where(accepted: false) }, class_name: "Follow", foreign_key: "follower_id"

  has_many :followers, through: :accepted_recieved_requests, source: :follower
  has_many :followings, through: :accepted_sent_requests, source: :followed
  has_many :waiting_followings, through: :waiting_sent_requests, source: :followed

  # def follow(user)  
  #   # self = me
  #   Follow.create(follower: self, followed: user)
  # end

  after_create :follow_all_users
  # after_create :follow_all_users, if: :admin?


  def follow(user)
    unless self.followings.include?(user)
      Follow.create(follower: self, followed: user)
    end
  end

  def unfollow(user)
    self.accepted_sent_requests.find_by(followed: user)&.destroy
  end

  def cancel_request(user)
    self.waiting_sent_requests.find_by(followed: user)&.destroy
  end
  
  def toggle_role
    if normal?
      admin!
    else
      normal!
    end
  end

  # def follow_all_users
  #   if self.admin
  #     User.where.not(id: self.id).each do |user|
  #       follow(user)
  #     end
  #   end
  # end
  def follow_all_users
    if super_admin?
      User.where.not(id: self.id).each do |user|
        follow(user)
      end
    end
  end

   def super_admin?
    roles.exists?(name: 'Super Admin')
  end
end
