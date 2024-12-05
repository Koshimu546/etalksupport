class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  has_one :profile, dependent: :destroy
  has_many :likes, dependent: :destroy

  # 条件付きバリデーション: サインアップ時はスキップ
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 50 }, unless: :new_record?

  # フォロー機能の関連付け
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  # OAuthログイン時の処理
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.username = auth.info.name || "user_#{SecureRandom.hex(4)}"
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
