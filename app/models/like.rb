class Like < ApplicationRecord
  belongs_to :user
  belongs_to :profile

  validates :field, presence: true # フィールド（対象項目）は必須
end
