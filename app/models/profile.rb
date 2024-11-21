class Profile < ApplicationRecord
  belongs_to :user

  validates :username, presence: true, uniqueness: true
  has_many :likes, dependent: :destroy
end
