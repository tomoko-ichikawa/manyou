class Group < ApplicationRecord
	has_many :favorites, dependent: :destroy
	has_many :users, through: :favorites

	def admission(user)
		favorites.create(user_id: user.id)
	end

	def withdrawal(user)
		favorites.find_by(user_id: user.id).destroy
	end

end
