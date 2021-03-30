class User < ApplicationRecord
    has_one_attached :avatar
    has_secure_password
    has_many :microposts
    has_many :likes, dependent: :destroy
    has_many :liked_microposts, through: :likes, source: :micropost
    has_many :comments, dependent: :destroy
    validates :name, presence: true, length: { maximum: 20 }
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
    
    has_many :follower, class_name: "Relationship",
                                    foreign_key: "follower_id",
                                    dependent: :destroy
    has_many :followed, class_name: "Relationship",
                                    foreign_key: "followed_id",
                                    dependent: :destroy
    has_many :follower_user, through: :followed, source: :follower
    has_many :following_user, through: :follower, source: :followed

    def already_liked?(micropost)
        self.likes.exists?(micropost_id: micropost.id)
    end
    
    def follow(user_id)
        follower.create(followed_id: user_id)
    end

    def unfollow(user_id)
        follower.find_by(followed_id: user_id).destroy
    end

    def following?(user)
        following_user.include?(user)
    end
     
    def self.search(search)
        return User.all unless search
        User.where(['name LIKE ?', "%#{search}%"])
    end
end
