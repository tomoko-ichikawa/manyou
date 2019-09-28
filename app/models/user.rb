class User < ApplicationRecord
  validates :user_name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: {maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6 }
  before_validation { email.downcase! }
  has_secure_password

  before_destroy :do_not_destroy_last_admin
  has_many :tasks, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_groups, through: :favorites, source: :group
  has_many :groups, through: :favorites, foreign_key: 'user_id'

  def do_not_destroy_last_admin
    if self.admin? && User.where(admin: :true).count == 1
      throw :abort
    end
  end
end
