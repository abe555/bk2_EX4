class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, presence: true, length: {maximum: 20, minimum: 2}
  validates :introduction, length: {maximum: 50}

  has_many :books, dependent: :destroy
  attachment :profile_image, destroy: :false

  has_many :active_relationship, class_name: "Relationship", foregin_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower
  has_many :passive_relationship, class_name: "Relationship", foregin_key: :follower_id
  has_many :followers, through: :passive_relationships, sorce: :following

  def followed_by?(user)
  	passive_relationships.find_by(following_id: user.id).present?
  end

end
