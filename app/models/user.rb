class User < ApplicationRecord
  attr_accessor :remember_token
  # before_create :remember
  has_secure_password
  has_many :posts
  # ADD VALIDATION
  before_save { email.downcase! }
  validates :name, presence: true, length: { maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def authenticated?(token)
    BCrypt::Password.new(remember_digest).is_password?(token)
  end

  def self.encrypt(token)
    # Digest::SHA1.hexdigest(token.to_s)

    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(token, cost: cost)
  end
 
  # Set remember_token
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.encrypt(remember_token))
  end

  # Remove remember_token
  def forget
    update_attribute(:remember_digest, nil)
  end

end
