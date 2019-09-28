class Group < ApplicationRecord
	has_many :favorites, dependent: :destroy, foreign_key: 'user_id'
	has_many :favorite_users, through: :favorites, source: :user, foreign_key: 'user_id'

	def favorited_by?(user)
        favorites.where(user_id: user.id).exists?
    end
end
