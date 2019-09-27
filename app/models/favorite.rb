class Favorite < ApplicationRecord
	belongs_to :user
	belongs_to :group, counter_cache: :likes_count
	validates :user_id, presence: true
  	validates :group_id, presence: true
end
