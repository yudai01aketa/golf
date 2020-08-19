class User < ApplicationRecord
  has_many :courses, dependent: :destroy
  has_many :courses, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :lists, dependent: :destroy

  attr_accessor :remember_token
  before_save :downcase_email
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validate  :image_size
  mount_uploader :image, ImageUploader

  def downcase_email
    self.email = email.downcase
  end

  class << self
    # 渡された文字列のハッシュ値を返す
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # ランダムなトークンを返す
    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end

  # フィード一覧を取得
  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
    Course.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end

  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  # 現在のユーザーがフォローされていたらtrueを返す
  def followed_by?(other_user)
    followers.include?(other_user)
  end

  # コースをお気に入りに登録する
  def favorite(course)
    Favorite.create!(user_id: id, course_id: course.id)
  end

  # コースをお気に入り解除する
  def unfavorite(course)
    Favorite.find_by(user_id: id, course_id: course.id).destroy
  end

  # 現在のユーザーがお気に入り登録してたらtrueを返す
  def favorite?(course)
    Favorite.exists?(user_id: id, course_id: course.id)
  end

  # コースをリストに登録する
  def list(course)
    List.create!(user_id: course.user_id, course_id: course.id, from_user_id: id)
  end

  # コースをリストから解除する
  def unlist(list)
    list.destroy
  end

  # 現在のユーザーがリスト登録してたらtrueを返す
  def list?(course)
    List.exists?(course_id: course.id, from_user_id: id)
  end

  def self.guest
    find_or_create_by(name: "ゲストユーザー", email: 'sample@example.com') do |user|
      user.password = "foobar"
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
  end

  private

  def image_size
    if image.size > 5.megabytes
      errors.add(:image, "：5MBより大きい画像はアップロードできません。")
    end
  end
end
