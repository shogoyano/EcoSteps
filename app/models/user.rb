class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

        has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
        has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
        has_many :followings, through: :following_relationships
        has_many :followers, through: :follower_relationships
        has_many :actives, dependent: :destroy
        has_many :likes, dependent: :destroy
        has_many :liked_actives, through: :likes, source: :active
        has_many :comments, dependent: :destroy
        validates :name, presence: true 
        validates :profile, length: { maximum: 200 } 

        mount_uploader :image, ImageUploader

        def already_liked?(active)
          self.likes.exists?(active_id: active.id)
        end

        def following?(other_user)
          following_relationships.find_by(following_id: other_user.id)
        end
      
        def follow!(other_user)
          following_relationships.create!(following_id: other_user.id)
        end
      
        def unfollow!(other_user)
          following_relationships.find_by(following_id: other_user.id).destroy
        end
   
end
