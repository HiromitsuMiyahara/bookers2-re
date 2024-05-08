class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  # 自分がフォローする側の関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # フォローしているユーザーを取得
  has_many :followings, through: :relationships, source: :followed
  
  # 自分がフォローされる側の関係性
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # フォローしているユーザーを取得
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }
  
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  
  # 指定したユーザーをフォローする
  def follow(user)
    relationships.create(followed_id: user.id)
  end
  
  # 指定したユーザーのフォローを解除する
  def unfollow(user)
    relationships.find_by(followed_id: user.id).destroy
  end
  
  # 指定したユーザーをフォローしているかどうかを判定
  def following?(user) #指定したユーザーをフォローしているかどうかを真偽値で返すメソッド
    followings.include?(user)
  end
end
