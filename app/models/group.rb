class Group < ApplicationRecord
	has_many :favorites, dependent: :destroy
	has_many :favorite_users, through: :favorites, source: :user

	def favorited_by?(user)
        favorites.where(user_id: user.id).exists?
    end
end
