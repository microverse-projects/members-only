class User < ApplicationRecord
  attr_accessor :remember_token
  before_create :remember
  has_secure_password

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def authenticated?(remember_token)
    BCrypt::Password.new(:remember_digest).is_password?(remember_token)
  end

  def self.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
 

  # Set remember_token
  def remember
    self.remember_token = User.new_token
    self.remember_token = User.encrypt(remember_token)
  end

  # Remove remember_token
  def forget
    update_attribute(:remember_token, nil)
  end

end
