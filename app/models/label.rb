class Label < ApplicationRecord
  has_many :tasks, through: :tags
  has_many :tags, dependent: :destroy
end
